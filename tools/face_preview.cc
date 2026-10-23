// SPDX-License-Identifier: MIT
#include <algorithm>
#include <filesystem>
#include <fstream>
#include <stdexcept>
#include <vector>
#include "face_raster.h"

#ifdef ROBOT_MARVIN
namespace robot = marvin;
#else
namespace robot = walle;
#endif

int main(int argc, char** argv) {
    if (argc != 2) {
        return 2;
    }
    std::filesystem::create_directories(argv[1]);
    constexpr uint16_t guard = 0x7abc;
    constexpr int margin = 32;
    std::vector<uint16_t> storage(robot::W * robot::H + 2 * margin, guard);
    auto pixels = storage.data() + margin;
    robot::Raster raster(pixels);
    const char* moods[] = {"idle", "happy",     "sleep",     "love",     "dizzy",
                           "wink", "surprised", "listening", "thinking", "speaking"};
    for (int frame = 0; frame < 16; ++frame) {
        if (frame < 10) {
            raster.Face(1.25f, moods[frame]);
            raster.Rect(25, 211, 234, 28, robot::Color(7, 25, 36));
            raster.Text("点这里说话", 216, 16);
        } else {
            raster.Fortune(frame - 10, false, 1250);
        }
        for (int i = 0; i < margin; ++i) {
            if (storage[i] != guard || storage[storage.size() - 1 - i] != guard) {
                throw std::runtime_error("Raster wrote outside its canvas");
            }
        }
        auto path = std::filesystem::path(argv[1]) / (std::to_string(frame) + ".ppm");
        std::ofstream file(path, std::ios::binary);
        file << "P6\n" << robot::W << " " << robot::H << "\n255\n";
        for (int i = 0; i < robot::W * robot::H; ++i) {
            uint16_t c = pixels[i];
            char rgb[] = {char(((c >> 11) & 31) * 255 / 31), char(((c >> 5) & 63) * 255 / 63),
                          char((c & 31) * 255 / 31)};
            file.write(rgb, 3);
        }
        if (!file) {
            throw std::runtime_error("Cannot write preview");
        }
    }
}
