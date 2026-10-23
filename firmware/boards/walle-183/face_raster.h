// SPDX-License-Identifier: MIT
#pragma once
#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstring>
#include "face_glyphs.h"

namespace walle {
constexpr int W = 284, H = 240;
constexpr uint16_t Color(int r, int g, int b) {
    return ((r & 248) << 8) | ((g & 252) << 3) | (b >> 3);
}
constexpr auto Metal = Color(48, 58, 65), Edge = Color(98, 118, 129), Dark = Color(9, 17, 23);
constexpr auto Glass = Color(3, 14, 24), Blue0 = Color(10, 54, 90), Blue1 = Color(21, 100, 154);
constexpr auto Blue2 = Color(62, 187, 239), Blue3 = Color(157, 231, 255), Pupil = Color(1, 6, 12);
constexpr auto White = Color(235, 251, 255), Pink = Color(255, 111, 165),
               Gold = Color(255, 201, 96);

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
        int cy = 120 + int(1.4f * std::sin(t * 1.6f));
        Rect(126, cy - 8, 32, 16, Metal);
        Line(130, cy - 7, 154, cy - 7, Edge);
        Ellipse(142, cy, 4, 4, Edge);
        Ellipse(142, cy, 2, 2, Dark);
        static const int outline[] = {-53, -25, -39, -44, 22,  -46, 47,  -27,
                                      50,  25,  30,  44,  -34, 43,  -55, 22};
        for (int side = 0; side < 2; ++side) {
            int cx = side ? 206 : 78, mirror = side ? -1 : 1, y = cy;
            if (!std::strcmp(mood, "curious"))
                y += side ? 3 : -4;
            Polygon(cx, y, outline, 8, 1, mirror, Metal);
            Polygon(cx, y, outline, 8, .94, mirror, Edge);
            Polygon(cx, y, outline, 8, .90, mirror, Dark);
            Ellipse(cx, y, 39, 37, Blue0);
            Ellipse(cx, y, 36, 34, Glass);
            if (!std::strcmp(mood, "sleep")) {
                int ly = y + 9 + int(std::sin(t));
                Line(cx - 24, ly, cx + 24, ly, Color(37, 85, 110));
                Line(cx - 21, ly + 1, cx + 21, ly + 1, Color(37, 85, 110));
                continue;
            }
            if (!std::strcmp(mood, "happy")) {
                int ry = std::max(2, int(21 * (1 - blink)));
                Ellipse(cx, y + 10, 26, ry, Blue2, true, 1);
                Ellipse(cx, y + 10, 21, std::max(1, ry - 5), Glass, true, 1);
                continue;
            }
            if (!std::strcmp(mood, "love")) {
                Heart(cx, y, 1.05);
                continue;
            }
            if (!std::strcmp(mood, "dizzy")) {
                int px = cx, py = y;
                for (int j = 1; j < 56; ++j) {
                    float a = j * .34f + t * 2 * mirror, r = j * .47f;
                    int x1 = cx + int(std::cos(a) * r), y1 = y + int(std::sin(a) * r);
                    Line(px, py, x1, y1, Gold);
                    Line(px + 1, py, x1 + 1, y1, Gold);
                    px = x1;
                    py = y1;
                }
                continue;
            }
            float b = (!std::strcmp(mood, "wink") && !side) ? std::max(blink, .96f) : blink;
            float open = std::max(.03f, 1 - b);
            bool surprise = !std::strcmp(mood, "surprised");
            int xr = surprise ? 32 : 29, yr = std::max(1, int((surprise ? 31 : 28) * open));
            int x = cx + std::clamp(int(gx), -8, 8), ey = y + std::clamp(int(gy), -6, 6);
            Ellipse(x, ey, xr, yr, Blue0);
            Ellipse(x, ey, xr - 2, std::max(1, yr - 2), Blue2);
            Ellipse(x, ey, xr - 6, std::max(1, yr - 6), Blue1);
            Ellipse(x, ey, xr - 9, std::max(1, yr - 9), Blue2, false);
            int pr = surprise ? 9 : 14;
            Ellipse(x, ey, pr, std::max(1, int(pr * open)), Pupil);
            if (open > .18f) {
                Ellipse(x - 8, ey - int(9 * open), 5, std::max(1, int(5 * open)), White);
                Ellipse(x + 9, ey + int(10 * open), 2, std::max(1, int(2 * open)), Blue3);
            }
        }
        if (!std::strcmp(mood, "love"))
            for (int i = 0; i < 3; ++i)
                Heart(56 + i * 86, 54 - int(std::fmod(t * 14 + i * 13, 27)), .33);
    }
    void Fortune(int result, bool rolling, uint32_t ms) {
        Clear();
        Text("瓦力好运签", 24, 18, Gold);
        Rect(33, 62, 218, 121, Color(41, 103, 128));
        Rect(35, 64, 214, 117, Color(7, 25, 36));
        static const char* titles[] = {"大吉", "摸鱼", "喝水", "伸懒腰", "走一走", "抱抱"};
        static const char* captions[] = {"今天会有小惊喜", "休息一下也很好", "喝口水再出发",
                                         "活动一下肩膀",   "出去透透气",     "给自己一点温柔"};
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
}  // namespace walle
