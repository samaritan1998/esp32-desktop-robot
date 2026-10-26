# SPDX-License-Identifier: MIT
"""Package each model with its editable sources, assembly guide and licenses."""
from pathlib import Path
import argparse
import hashlib
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--version', default='0.1.0')
    parser.add_argument('--out', type=Path, default=ROOT/'dist')
    args = parser.parse_args()
    if not args.version or any(c not in '0123456789.-abcdefghijklmnopqrstuvwxyz' for c in args.version):
        parser.error('Use a plain version string, e.g. 0.1.0')
    args.out.mkdir(parents=True, exist_ok=True)
    hashes = []
    for robot in ('walle', 'marvin-v4'):
        stem = f'{robot}-print-kit-v{args.version}'
        path = args.out/(stem+'.zip')
        selected = [ROOT/'LICENSE', ROOT/'THIRD_PARTY_NOTICES.md', ROOT/'models/LICENSE.md']
        guide = ROOT/'docs/images'/(robot+'-assembly-guide.png')
        if guide.exists():
            selected.extend([guide, ROOT/'docs/images/LICENSE.md'])
        shim_guide = ROOT/'docs/images'/(robot+'-shim-guide.png')
        if shim_guide.exists():
            selected.append(shim_guide)
        selected.extend((ROOT/'LICENSES').glob('*.txt'))
        selected.extend(p for p in (ROOT/'models'/robot).rglob('*') if p.is_file()
                        and '__pycache__' not in p.parts and p.suffix != '.pyc')
        readme = (f'# {robot} 打印套装 v{args.version}\n\n'
                  f'请先打开 `models/{robot}/README.md`。保持毫米单位、100% 比例；'
                  '这是模型与源码包，不含打印机设置、支撑、G-code 或固件。\n\n'
                  '模型与装配图文在可授权范围内使用 CC BY-SA 4.0；Python 工具使用 MIT。'
                  '角色形象及商标等第三方权利不随文件授权。许可全文见 LICENSES 和 models/LICENSE.md。\n\n'
                  'WALL-E 有首位制作者装入成功反馈；Marvin V4 已完成几何检查，尚未实物确认。'
                  '代打时最好由打印方拿到带原装黑壳的屏幕完成装配。\n\n'
                  '项目：https://github.com/samaritan1998/esp32-desktop-robot\n')
        with zipfile.ZipFile(path, 'w', zipfile.ZIP_DEFLATED) as archive:
            archive.writestr(stem+'/README.md', readme)
            for p in sorted(selected):
                archive.write(p, stem+'/'+p.relative_to(ROOT).as_posix())
        with zipfile.ZipFile(path) as archive:
            assert archive.testzip() is None
            for p in selected:
                assert archive.read(stem+'/'+p.relative_to(ROOT).as_posix()) == p.read_bytes()
            assert all(not name.endswith(('.bin', '.elf', '.log', '.pyc')) for name in archive.namelist())
        hashes.append(hashlib.sha256(path.read_bytes()).hexdigest()+'  '+path.name)
        print(f'{path.name}: {path.stat().st_size} bytes, {len(selected)+1} files')
    (args.out/'SHA256SUMS.txt').write_text('\n'.join(hashes)+'\n')


if __name__ == '__main__':
    main()
