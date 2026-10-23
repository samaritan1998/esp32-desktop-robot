// SPDX-License-Identifier: MIT
#pragma once
#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstring>
#include "face_glyphs.h"

namespace marvin {
constexpr int W = 284, H = 240;
constexpr uint16_t Color(int r, int g, int b) {
    return ((r & 248) << 8) | ((g & 252) << 3) | (b >> 3);
}
constexpr auto Metal = Color(48, 58, 65), Edge = Color(98, 118, 129), Dark = Color(9, 17, 23);
constexpr auto Glass = Color(3, 14, 24), Blue0 = Color(16, 38, 27), Blue1 = Color(90, 143, 110);
constexpr auto Blue2 = Color(166, 218, 182), Blue3 = Color(195, 235, 207), Pupil = Color(1, 6, 12);
constexpr auto White = Color(235, 251, 255), Pink = Color(255, 111, 165),
               Gold = Color(195, 235, 207);

class Raster {
public:
    uint16_t* pixels;
    explicit Raster(uint16_t* p) : pixels(p) {}
    void Clear() { std::fill(pixels, pixels + W * H, 0); }
    void Pixel(int x, int y, uint16_t c) {
        if (x >= 0 && x < W && y >= 0 && y < H)
            pixels[y * W + x] = c;
    }
    void Rect(int x, int y, int w, int h, uint16_t c) {
        int x0 = std::max(0, x), x1 = std::min(W, x + w);
        if (x0 >= x1)
            return;
        for (int j = std::max(0, y); j < std::min(H, y + h); ++j)
            std::fill(pixels + j * W + x0, pixels + j * W + x1, c);
    }
    void Line(int x0, int y0, int x1, int y1, uint16_t c) {
        int dx = std::abs(x1 - x0), sx = x0 < x1 ? 1 : -1, dy = -std::abs(y1 - y0),
            sy = y0 < y1 ? 1 : -1, e = dx + dy;
        for (;;) {
            Pixel(x0, y0, c);
            if (x0 == x1 && y0 == y1)
                break;
            int e2 = 2 * e;
            if (e2 >= dy) {
                e += dy;
                x0 += sx;
            }
            if (e2 <= dx) {
                e += dx;
                y0 += sy;
            }
        }
    }
    void Ellipse(int x, int y, int rx, int ry, uint16_t c, bool fill = true, int half = 0) {
        rx = std::max(1, rx);
        ry = std::max(1, ry);
        for (int j = -ry; j <= ry; ++j) {
            if ((half == 1 && j > 0) || (half == 2 && j < 0))
                continue;
            int span =
                static_cast<int>(rx * std::sqrt(std::max(0.0, 1.0 - double(j * j) / (ry * ry))));
            if (fill)
                Rect(x - span, y + j, 2 * span + 1, 1, c);
            else {
                Pixel(x - span, y + j, c);
                Pixel(x + span, y + j, c);
            }
        }
    }
    void Polygon(int cx, int cy, const int* points, int count, float scale, int mirror,
                 uint16_t c) {
        int xs[20], ys[20];
        int low = H, high = -1;
        for (int i = 0; i < count; ++i) {
            xs[i] = cx + int(points[2 * i] * scale * mirror);
            ys[i] = cy + int(points[2 * i + 1] * scale);
            low = std::min(low, ys[i]);
            high = std::max(high, ys[i]);
        }
        for (int y = std::max(0, low); y <= std::min(H - 1, high); ++y) {
            int nodes[20], n = 0;
            for (int i = 0, j = count - 1; i < count; j = i++) {
                if ((ys[i] <= y && ys[j] > y) || (ys[j] <= y && ys[i] > y))
                    nodes[n++] = xs[i] + (y - ys[i]) * (xs[j] - xs[i]) / (ys[j] - ys[i]);
            }
            std::sort(nodes, nodes + n);
            for (int i = 0; i + 1 < n; i += 2)
                Rect(nodes[i], y, nodes[i + 1] - nodes[i] + 1, 1, c);
        }
    }
    void Heart(int x, int y, float scale, uint16_t c = Pink) {
        static const int p[] = {-17, -7,  -14, -15, -7, -18, 0, -11, 7,   -18,
                                14,  -15, 17,  -7,  14, 2,   0, 18,  -14, 2};
        Polygon(x, y, p, 10, scale, 1, c);
    }
    void Text(const char* s, int y, int size, uint16_t c = Blue3, int x = -1) {
        int count = 0;
        for (auto p = (const uint8_t*)s; *p; ++p)
            if ((*p & 0xc0) != 0x80)
                ++count;
        if (x < 0)
            x = (W - count * size) / 2;
        auto p = (const uint8_t*)s;
        while (*p) {
            uint32_t cp = *p++;
            if (cp >= 0xe0) {
                cp = (cp & 15) << 12;
                cp |= (*p++ & 63) << 6;
                cp |= *p++ & 63;
            } else if (cp >= 0xc0) {
                cp = (cp & 31) << 6;
                cp |= *p++ & 63;
            }
            for (const auto& g : kFaceGlyphs) {
                if (g.size != size || g.codepoint != cp)
                    continue;
                int stride = (size + 7) / 8;
                for (int j = 0; j < size; ++j)
                    for (int i = 0; i < size; ++i)
                        if (g.data[j * stride + i / 8] & (128 >> (i % 8)))
                            Pixel(x + i, y + j, c);
                break;
            }
            x += size;
        }
    }
    void Face(float t, const char* mood, float gx = 0, float gy = 0, float blink = 0) {
        Clear();
        const auto light = Color(195, 235, 207);
        const auto dim = Color(74, 119, 94);
        const auto pupil = Color(2, 9, 7);
        const bool asleep = !std::strcmp(mood, "sleep");
        const bool happy = !std::strcmp(mood, "happy");
        const bool love = !std::strcmp(mood, "love");
        const bool surprise = !std::strcmp(mood, "surprised");
        const bool listening = !std::strcmp(mood, "listening");
        const bool speaking = !std::strcmp(mood, "speaking");
        const bool thinking = !std::strcmp(mood, "thinking");
        int cy = 108 + int(std::sin(t * .9f));
        for (int side = 0; side < 2; ++side) {
            int cx = side ? 201 : 83;
            int y = cy + ((!std::strcmp(mood, "curious") && side) ? -4 : 0);
            float b = (!std::strcmp(mood, "wink") && !side) ? .97f : blink;
            if (asleep || b > .88f) {
                Line(cx - 30, y + 9, cx + 30, y + 12, dim);
                Line(cx - 28, y + 10, cx + 28, y + 13, dim);
                continue;
            }
            if (love) {
                Heart(cx, y + 5, 1.0f, Color(223, 170, 181));
                continue;
            }
            if (!std::strcmp(mood, "dizzy")) {
                int px = cx, py = y;
                for (int j = 1; j < 62; ++j) {
                    float a = j * .31f + t * 1.6f, r = j * .46f;
                    int x1 = cx + int(std::cos(a) * r), y1 = y + int(std::sin(a) * r);
                    Line(px, py, x1, y1, light);
                    Line(px + 1, py, x1 + 1, y1, light);
                    px = x1;
                    py = y1;
                }
                continue;
            }
            if (happy) {
                Ellipse(cx, y + 12, 32, 18, light, true, 1);
                Ellipse(cx, y + 12, 27, 13, 0, true, 1);
                continue;
            }
            int ry = std::max(1, int((surprise ? 33 : 27) * (1 - b)));
            Ellipse(cx, y + 5, 39, ry, dim);
            Ellipse(cx, y + 5, 36, std::max(1, ry - 2), light);
            int x = cx + std::clamp(int(gx), -8, 8);
            int py = y + 9 + std::clamp(int(gy), -4, 4);
            Ellipse(x, py, surprise ? 9 : 11, std::max(1, int(12 * (1 - b))), pupil);
            Ellipse(x - 3, py - 4, 2, 2, Color(239, 255, 240));
            // Heavy upper lids are the signature, even while awake and speaking.
            if (!surprise) {
                int lid = y + (listening ? -11 : thinking ? -2 : 0) + int(b * 32);
                int slope = side ? -3 : 3;
                int cover[] = {-43, -40, 43, -40, 43, lid - y - slope, -43, lid - y + slope};
                Polygon(cx, y, cover, 4, 1, 1, 0);
                Line(cx - 36, lid + slope, cx + 36, lid - slope, dim);
            }
        }
        int mouth_y = 158 + (asleep ? int(std::sin(t)) : 0);
        if (speaking) {
            Ellipse(142, mouth_y, 13, 2 + int((std::sin(t * 6) + 1) * 2), dim);
            Ellipse(142, mouth_y, 10, 1 + int((std::sin(t * 6) + 1) * 1.5f), pupil);
        } else if (surprise) {
            Ellipse(142, mouth_y, 6, 8, dim, false);
        } else {
            int last_x = 124, last_y = mouth_y;
            for (int x = -18; x <= 18; ++x) {
                float curve = 1 - x * x / 324.f;
                int y = mouth_y + int((happy || love ? 4 : -4) * curve);
                Line(last_x, last_y, 142 + x, y, dim);
                Line(last_x, last_y + 1, 142 + x, y + 1, dim);
                last_x = 142 + x;
                last_y = y;
            }
        }
        if (asleep) {
            int y = 62 + int(std::sin(t) * 2);
            Line(222, y, 232, y, dim);
            Line(232, y, 222, y + 10, dim);
            Line(222, y + 10, 232, y + 10, dim);
        }
    }
    void Fortune(int result, bool rolling, uint32_t ms) {
        Clear();
        Text("宇宙摆烂签", 24, 18, Gold);
        Rect(33, 62, 218, 121, Color(41, 103, 128));
        Rect(35, 64, 214, 117, Color(7, 25, 36));
        static const char* titles[] = {"摸鱼", "充电", "发呆", "喝水", "散步", "大吉"};
        static const char* captions[] = {"今天先放过自己", "电量不够就休息", "宇宙也需要暂停",
                                         "喝口水继续躺平", "出去看看这宇宙", "好事偶尔也发生"};
        if (result < 0) {
            Text("轻点抽一个", 94, 28);
            Text("摇一摇也能抽", 143, 16, Blue1);
        } else {
            int i = rolling ? (ms / 85) % 6 : result;
            Text(titles[i], 84, 36, Gold);
            Text(rolling ? "正在抽签" : captions[i], 143, 16);
        }
        Text("轻点再抽", 196, 16, Blue3, 37);
        Text("双击返回", 196, 16, Blue3, 181);
    }
};
}  // namespace marvin
