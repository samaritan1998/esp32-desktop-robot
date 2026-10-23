// SPDX-License-Identifier: MIT
#pragma once
#include <driver/i2c_master.h>
#include <esp_heap_caps.h>
#include <esp_random.h>
#include <esp_system.h>
#include <esp_timer.h>
#include <array>
#include <cstdio>
#include "application.h"
#include "assets/lang_config.h"
#include "display/lcd_display.h"
#include "face_raster.h"
#include "lvgl_theme.h"

// One LVGL timer owns the canvas, sensor reads and gesture state. Audio keeps its
// existing tasks; this renderer never allocates a frame in the audio path.
class WalleDisplay : public SpiLcdDisplay {
    // Driver deadlines are converted to RTOS ticks. At 100Hz, 3-5ms becomes
    // zero ticks and even healthy transfers time out before the ISR completes.
    static constexpr int kI2cTimeoutMs = 40;
    static_assert(pdMS_TO_TICKS(kI2cTimeoutMs) > 0, "I2C deadline must cover an RTOS tick");
    uint16_t* pixels_ = nullptr;
    lv_obj_t* canvas_ = nullptr;
    lv_timer_t* timer_ = nullptr;
    i2c_master_dev_handle_t touch_ = nullptr, imu_ = nullptr;
    uint32_t press_at_ = 0, last_seen_ = 0, last_tap_ = 0, last_pet_ = 0, last_activity_ = 0;
    uint32_t mood_until_ = 0, next_emote_ = 8000, roll_until_ = 0, last_peak_ = 0, last_shake_ = 0;
    uint32_t frame_ = 0;
    uint32_t motion_samples_ = 0;
    bool pressed_ = false, moved_ = false, woke_ = false, manual_sleep_ = false, fortune_ = false;
    int start_x_ = 0, start_y_ = 0, hold_stage_ = 0, pet_count_ = 0, result_ = -1;
    std::string mood_ = "idle", emotion_ = "neutral";
    float gaze_x_ = 0, gaze_y_ = 0, tilt_x_ = 0, tilt_y_ = 0;
    std::array<float, 3> previous_{}, reference_{};
    int calibration_ = 0;
    DeviceState previous_state_ = kDeviceStateUnknown;
    std::function<void()> activity_;
    bool thinking_ = false;
    static void Console(void* arg) {
        auto self = static_cast<WalleDisplay*>(arg);
        char line[96];
        size_t length = 0;
        for (;;) {
            int ch = getchar();
            if (ch == EOF) {
                std::clearerr(stdin);
                vTaskDelay(pdMS_TO_TICKS(30));
                continue;
            }
            if (ch != '\n' && ch != '\r') {
                if (length + 1 < sizeof(line))
                    line[length++] = char(ch);
                continue;
            }
            line[length] = 0;
            length = 0;
            if (!std::strcmp(line, "walle.status")) {
                DisplayLockGuard guard(self);
                if (!guard)
                    continue;
                printf(
                    "WALLE_STATUS "
                    "{\"version\":\"3.0.2\",\"state\":%d,\"frames\":%lu,\"touch\":%d,\"imu\":%d,"
                    "\"motion_samples\":%lu,\"accel_g\":[%.3f,%.3f,%.3f],\"heap\":%u}\n",
                    int(Application::GetInstance().GetDeviceState()), (unsigned long)self->frame_,
                    self->touch_ != nullptr, self->imu_ != nullptr,
                    (unsigned long)self->motion_samples_, double(self->previous_[0]),
                    double(self->previous_[1]), double(self->previous_[2]),
                    unsigned(esp_get_free_heap_size()));
            } else if (!std::strcmp(line, "walle.voice")) {
                Application::GetInstance().ToggleChatState();
            } else if (!std::strcmp(line, "walle.audio")) {
                auto& app = Application::GetInstance();
                auto codec = Board::GetInstance().GetAudioCodec();
                printf("WALLE_AUDIO aec=%d volume=%d input=%d output=%d playback_idle=%d\n",
                       int(app.GetAecMode()), codec->output_volume(), codec->input_enabled(),
                       codec->output_enabled(), app.GetAudioService().IsPlaybackIdle());
            } else if (!std::strcmp(line, "walle.sound")) {
                Application::GetInstance().Schedule(
                    []() { Application::GetInstance().PlaySound(Lang::Sounds::OGG_POPUP); });
            } else if (!std::strcmp(line, "walle.aec.off")) {
                Application::GetInstance().Schedule(
                    []() { Application::GetInstance().SetAecMode(kAecOff); });
            } else if (!std::strcmp(line, "walle.aec.on")) {
                Application::GetInstance().Schedule(
                    []() { Application::GetInstance().SetAecMode(kAecOnDeviceSide); });
            } else if (!std::strcmp(line, "walle.snapshot")) {
                std::string jpeg;
                if (self->SnapshotToJpeg(jpeg, 75)) {
                    printf("WALLE_JPEG_BEGIN %u\n", unsigned(jpeg.size()));
                    for (size_t i = 0; i < jpeg.size(); i += 64) {
                        char hex[129];
                        size_t n = std::min(size_t(64), jpeg.size() - i);
                        for (size_t j = 0; j < n; ++j)
                            std::snprintf(hex + j * 2, 3, "%02x", uint8_t(jpeg[i + j]));
                        printf("WALLE_JPEG_DATA %s\n", hex);
                    }
                    printf("WALLE_JPEG_END\n");
                } else
                    printf("WALLE_SNAPSHOT_UNAVAILABLE\n");
            }
        }
    }
    static uint32_t Now() { return esp_timer_get_time() / 1000; }
    static bool Due(uint32_t now, uint32_t deadline) { return int32_t(now - deadline) >= 0; }
    bool Read(i2c_master_dev_handle_t dev, uint8_t reg, uint8_t* data, size_t n) {
        return dev && i2c_master_transmit_receive(dev, &reg, 1, data, n, kI2cTimeoutMs) == ESP_OK;
    }
    void Write(i2c_master_dev_handle_t dev, uint8_t reg, uint8_t value) {
        const uint8_t b[] = {reg, value};
        if (dev) {
            esp_err_t err = i2c_master_transmit(dev, b, sizeof(b), kI2cTimeoutMs);
            if (err != ESP_OK)
                ESP_LOGW("Walle", "I2C write 0x%02x: %s", reg, esp_err_to_name(err));
        }
    }
    void AddDevice(i2c_master_bus_handle_t bus, uint16_t address, i2c_master_dev_handle_t* dev) {
        esp_err_t err = i2c_master_probe(bus, address, kI2cTimeoutMs);
        ESP_LOGI("Walle", "I2C probe 0x%02x: %s", address, esp_err_to_name(err));
        if (err != ESP_OK)
            return;
        i2c_device_config_t c = {};
        c.dev_addr_length = I2C_ADDR_BIT_LEN_7;
        c.device_address = address;
        c.scl_speed_hz = 400000;
        if (i2c_master_bus_add_device(bus, &c, dev) != ESP_OK)
            *dev = nullptr;
    }
    void Mood(const char* value, uint32_t now, uint32_t duration) {
        mood_ = value;
        mood_until_ = now + duration;
    }
    void EnterGame(uint32_t now) {
        fortune_ = true;
        manual_sleep_ = false;
        result_ = -1;
        last_tap_ = 0;
        last_activity_ = now;
        pet_count_ = 0;
    }
    void ExitGame(uint32_t now) {
        fortune_ = false;
        manual_sleep_ = false;
        last_activity_ = now;
        last_tap_ = 0;
        Mood("happy", now, 1400);
    }
    void Roll(uint32_t now) {
        result_ = esp_random() % 6;
        roll_until_ = now + 1250;
        last_activity_ = now;
    }
    void Tap(uint32_t now) {
        bool twice = last_tap_ && now - last_tap_ < 390;
        last_activity_ = now;
        if (fortune_) {
            if (twice)
                ExitGame(now);
            else {
                Roll(now);
                last_tap_ = now;
            }
            return;
        }
        if (!last_pet_ || now - last_pet_ > 1500)
            pet_count_ = 0;
        last_pet_ = now;
        ++pet_count_;
        if (pet_count_ >= 4) {
            pet_count_ = 0;
            Mood("love", now, 3800);
        } else if (mood_ != "love" || Due(now, mood_until_))
            Mood(twice ? "surprised" : "happy", now, 2000);
        last_tap_ = now;
    }
    void VoiceTap() {
        // Public API posts an event; protocol and device state stay on main task.
        auto& app = Application::GetInstance();
        DeviceState s = app.GetDeviceState();
        if (s == kDeviceStateIdle || s == kDeviceStateListening || s == kDeviceStateSpeaking ||
            s == kDeviceStateConnecting || s == kDeviceStateAudioTesting)
            app.ToggleChatState();
    }
    void Touch(uint32_t now, DeviceState state) {
        uint8_t d[6] = {};
        bool down = false;
        int x = 0, y = 0;
        if (Read(touch_, 1, d, 6) && (d[1] & 15)) {
            int raw_x = ((d[2] & 15) << 8) | d[3], raw_y = ((d[4] & 15) << 8) | d[5];
            if (raw_x < 240 && raw_y < 284) {
                x = raw_y;
                y = 239 - raw_x;
                down = true;
            }
        }
        bool playful = state == kDeviceStateIdle;
        if (down) {
            last_seen_ = now;
            last_activity_ = now;
            if (!pressed_) {
                if (activity_)
                    activity_();
                pressed_ = true;
                press_at_ = now;
                start_x_ = x;
                start_y_ = y;
                moved_ = false;
                hold_stage_ = 0;
                woke_ = false;
                if (playful && (manual_sleep_ || mood_ == "sleep")) {
                    manual_sleep_ = false;
                    woke_ = true;
                    Mood("curious", now, 1200);
                }
            }
            if (std::abs(x - start_x_) + std::abs(y - start_y_) > 18)
                moved_ = true;
            gaze_x_ = (x - 142) / 15.f;
            gaze_y_ = (y - 120) / 20.f;
            if (playful && !fortune_ && start_y_ < 210 && !moved_) {
                if (now - press_at_ >= 950 && hold_stage_ == 0) {
                    hold_stage_ = 1;
                    if (!woke_) {
                        manual_sleep_ = true;
                        Mood("sleep", now, 0);
                    }
                }
                if (now - press_at_ >= 2000 && hold_stage_ < 2) {
                    hold_stage_ = 2;
                    EnterGame(now);
                }
            }
        } else if (pressed_ && now - last_seen_ > 65) {
            pressed_ = false;
            if (!moved_ && hold_stage_ == 0) {
                if (!fortune_ && start_y_ >= 210)
                    VoiceTap();
                else if (playful && !woke_)
                    Tap(now);
            }
        }
    }
    void Motion(uint32_t now, bool playful) {
        uint8_t data[6];
        if (!Read(imu_, 0x35, data, 6))
            return;
        ++motion_samples_;
        std::array<float, 3> v{};
        for (int i = 0; i < 3; ++i)
            v[i] = int16_t(uint16_t(data[2 * i]) | (uint16_t(data[2 * i + 1]) << 8)) / 8192.f;
        if (calibration_ < 12) {
            for (int i = 0; i < 3; ++i)
                reference_[i] += v[i] / 12.f;
            previous_ = v;
            ++calibration_;
            return;
        }
        float dx = v[0] - previous_[0], dy = v[1] - previous_[1], dz = v[2] - previous_[2];
        float jerk = std::sqrt(dx * dx + dy * dy + dz * dz);
        previous_ = v;
        tilt_x_ += (std::clamp((v[1] - reference_[1]) * 15.f, -8.f, 8.f) - tilt_x_) * .18f;
        tilt_y_ += (std::clamp((v[0] - reference_[0]) * 12.f, -6.f, 6.f) - tilt_y_) * .18f;
        if (!playful || now - last_shake_ < 4500 || jerk < .85f)
            return;
        if (last_peak_ && now - last_peak_ > 110 && now - last_peak_ < 650) {
            last_shake_ = now;
            if (activity_)
                activity_();
            last_peak_ = 0;
            manual_sleep_ = false;
            last_activity_ = now;
            if (fortune_)
                Roll(now);
            else
                Mood("dizzy", now, 3000);
        } else if (!last_peak_ || now - last_peak_ >= 650)
            last_peak_ = now;
    }
    void Tick() {
        auto& app = Application::GetInstance();
        auto state = app.GetDeviceState();
        uint32_t now = Now();
        if (state != previous_state_) {
            thinking_ = false;
            ESP_LOGI("Walle", "VOICE_STATE %d", int(state));
            if (state != kDeviceStateIdle) {
                fortune_ = false;
                manual_sleep_ = false;
            } else
                last_activity_ = now;
            previous_state_ = state;
        }
        Touch(now, state);
        Motion(now, state == kDeviceStateIdle);
        bool setup = state == kDeviceStateWifiConfiguring || state == kDeviceStateActivating ||
                     state == kDeviceStateUpgrading || state == kDeviceStateFatalError;
        if (bottom_bar_) {
            lv_obj_set_align(bottom_bar_, LV_ALIGN_TOP_LEFT);
            lv_obj_set_pos(bottom_bar_, 0, setup ? 55 : 180);
            lv_obj_set_height(bottom_bar_, setup ? 130 : 28);
            lv_label_set_long_mode(chat_message_label_,
                                   setup ? LV_LABEL_LONG_WRAP : LV_LABEL_LONG_SCROLL_CIRCULAR);
            if (fortune_)
                lv_obj_add_flag(bottom_bar_, LV_OBJ_FLAG_HIDDEN);
        }
        walle::Raster r(pixels_);
        float t = now / 1000.f;
        if (fortune_) {
            if (now - last_activity_ > 30000)
                ExitGame(now);
            r.Fortune(result_, !Due(now, roll_until_), now);
        } else {
            const char* mood = "idle";
            float gx = pressed_ ? gaze_x_ : tilt_x_ + std::sin(t * .7f) * 3;
            float gy = pressed_ ? gaze_y_ : tilt_y_;
            if (state == kDeviceStateIdle) {
                if (manual_sleep_ || (!pressed_ && now - last_activity_ > 60000))
                    mood_ = "sleep";
                else if (mood_ != "idle" && !pressed_ && Due(now, mood_until_))
                    mood_ = "idle";
                if (mood_ == "idle" && Due(now, next_emote_)) {
                    const char* choices[] = {"wink", "happy", "curious"};
                    Mood(choices[esp_random() % 3], now, 1100);
                    next_emote_ = now + 12000 + esp_random() % 12000;
                }
                mood = mood_.c_str();
            } else if (state == kDeviceStateListening || state == kDeviceStateAudioTesting) {
                mood = "curious";
                gx = thinking_ ? std::sin(t * 2) * 6 : 0;
                gy = -2;
            } else if (state == kDeviceStateConnecting) {
                mood = "curious";
                gx = std::sin(t * 3) * 7;
            } else if (state == kDeviceStateSpeaking) {
                mood = (emotion_ == "happy" || emotion_ == "laughing" || emotion_ == "funny")
                           ? "happy"
                           : "idle";
                gx = std::sin(t * 2.8f) * 3;
                gy = std::sin(t * 4) * 1.5f;
            }
            float phase = std::fmod(t, 4.3f),
                  blink = phase < .18f ? 1 - std::abs(phase - .09f) / .09f : 0;
            r.Face(t, mood, gx, gy, blink);
            if (setup)
                r.Rect(0, 45, 284, 150, 0);
            r.Rect(25, 211, 234, 28, walle::Color(7, 25, 36));
            const char* prompt = "点这里说话";
            if (state == kDeviceStateListening && thinking_)
                prompt = "正在思考";
            else if (state == kDeviceStateListening || state == kDeviceStateAudioTesting)
                prompt = "轻点结束聆听";
            else if (state == kDeviceStateSpeaking)
                prompt = "正在回答";
            else if (state == kDeviceStateConnecting)
                prompt = "连接服务";
            else if (setup)
                prompt = "请先联网";
            r.Text(prompt, 216, 16, state == kDeviceStateListening ? walle::Pink : walle::Blue3);
        }
        lv_obj_invalidate(canvas_);
        if (++frame_ % 200 == 0)
            ESP_LOGI("Walle", "HEARTBEAT frames=%lu touch=%d imu=%d heap=%u", (unsigned long)frame_,
                     touch_ != nullptr, imu_ != nullptr, unsigned(esp_get_free_heap_size()));
    }

public:
    void SetActivityCallback(std::function<void()> callback) { activity_ = std::move(callback); }
    WalleDisplay(esp_lcd_panel_io_handle_t io, esp_lcd_panel_handle_t panel,
                 i2c_master_bus_handle_t bus)
        : SpiLcdDisplay(io, panel, 284, 240, 0, 0, true, false, true) {
        AddDevice(bus, 0x15, &touch_);
        Write(touch_, 0xfa, 0x40);
        AddDevice(bus, 0x6b, &imu_);
        uint8_t id = 0;
        if (Read(imu_, 0, &id, 1) && id == 5) {
            Write(imu_, 8, 0);
            Write(imu_, 2, 0x40);
            Write(imu_, 3, 0x16);
            Write(imu_, 6, 7);
            Write(imu_, 8, 1);
        } else
            imu_ = nullptr;
        pixels_ = static_cast<uint16_t*>(
            heap_caps_calloc(284 * 240, 2, MALLOC_CAP_SPIRAM | MALLOC_CAP_8BIT));
        ESP_ERROR_CHECK(pixels_ ? ESP_OK : ESP_ERR_NO_MEM);
    }
    void SetupUI() override {
        if (IsSetupUICalled())
            return;
        current_theme_ = LvglThemeManager::GetInstance().GetTheme("dark");
        LcdDisplay::SetupUI();
        DisplayLockGuard guard(this);
        if (!guard)
            return;
        lv_obj_remove_flag(lv_screen_active(), LV_OBJ_FLAG_SCROLLABLE);
        lv_obj_set_scrollbar_mode(lv_screen_active(), LV_SCROLLBAR_MODE_OFF);
        lv_obj_add_flag(emoji_box_, LV_OBJ_FLAG_HIDDEN);
        canvas_ = lv_canvas_create(lv_screen_active());
        lv_canvas_set_buffer(canvas_, pixels_, 284, 240, LV_COLOR_FORMAT_RGB565);
        lv_obj_set_pos(canvas_, 0, 0);
        lv_obj_remove_flag(canvas_, LV_OBJ_FLAG_CLICKABLE);
        lv_obj_move_to_index(canvas_, 1);
        last_activity_ = Now();
        timer_ = lv_timer_create(
            [](lv_timer_t* timer) {
                static_cast<WalleDisplay*>(lv_timer_get_user_data(timer))->Tick();
            },
            60, this);
        xTaskCreate(Console, "walle_usb", 6144, this, 1, nullptr);
        ESP_LOGI("Walle", "READY v3.0.2: landscape eyes, touch, motion, fortune, voice");
    }
    void SetEmotion(const char* emotion) override {
        DisplayLockGuard guard(this);
        if (guard)
            emotion_ = emotion ? emotion : "neutral";
    }
    void SetChatMessage(const char* role, const char* content) override {
        LcdDisplay::SetChatMessage(role, content);
        if (role && content && content[0] && std::strcmp(role, "user") == 0) {
            DisplayLockGuard guard(this);
            if (guard)
                thinking_ = true;
        }
    }
    void SetTheme(Theme*) override {
        LcdDisplay::SetTheme(LvglThemeManager::GetInstance().GetTheme("dark"));
    }
};
