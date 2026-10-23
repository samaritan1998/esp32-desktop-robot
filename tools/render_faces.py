# SPDX-License-Identifier: MIT
"""Compile the pure C++ face renderer and save a 16-frame contact sheet per robot."""
from pathlib import Path
import argparse
import subprocess
from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cxx', default='c++')
    parser.add_argument('--cxx-flag', action='append', default=[])
    parser.add_argument('--out', type=Path, default=ROOT/'.build/face-previews')
    args = parser.parse_args()
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=True)
    labels = ['idle', 'happy', 'sleep', 'love', 'dizzy', 'wink', 'surprised',
              'listening', 'thinking', 'speaking']+[f'fortune {i+1}' for i in range(6)]
    for board in ('marvin-183', 'walle-183'):
        frames = out/board
        frames.mkdir(exist_ok=True)
        binary = frames/'preview'
        command = [args.cxx, '-std=c++17', *args.cxx_flag,
                   '-I'+str(ROOT/'firmware/boards'/board)]
        if board == 'marvin-183':
            command.append('-DROBOT_MARVIN')
        subprocess.run(command+[str(ROOT/'tools/face_preview.cc'), '-o', str(binary)], check=True)
        subprocess.run([str(binary), str(frames)], check=True)
        sheet = Image.new('RGB', (4*284, 4*264), '#17202a')
        draw = ImageDraw.Draw(sheet)
        for i, label in enumerate(labels):
            x, y = i % 4 * 284, i // 4 * 264
            sheet.paste(Image.open(frames/f'{i}.ppm'), (x, y))
            draw.text((x+8, y+244), label, fill='white')
        path = out/(board+'.png')
        sheet.save(path)
        print(path)


if __name__ == '__main__':
    main()
