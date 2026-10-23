# SPDX-License-Identifier: MIT
"""Prepare a fresh, checksummed upstream tree plus the public robot sources.

Requires Python 3.12+ and git. This does not build or flash any device.
"""
from pathlib import Path
import argparse
import hashlib
import json
import shutil
import subprocess
import tarfile
import tempfile
import urllib.request

ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, default=ROOT/'.build/xiaozhi-esp32')
    parser.add_argument('--archive', type=Path, help='Optional cached, unmodified v2.5.2 archive')
    args = parser.parse_args()
    out = args.out.resolve()
    if out.exists():
        parser.error(f'Output already exists; choose a fresh --out directory: {out}')
    manifest = json.loads((ROOT/'firmware/upstream.json').read_text())
    out.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='robot-source-', dir=out.parent) as temp:
        temp = Path(temp)
        archive = args.archive.resolve() if args.archive else temp/'upstream.tar.gz'
        if not args.archive:
            print('Downloading pinned upstream archive...', flush=True)
            with urllib.request.urlopen(manifest['archive_url'], timeout=120) as response:
                with archive.open('wb') as target:
                    shutil.copyfileobj(response, target)
        digest = hashlib.sha256(archive.read_bytes()).hexdigest()
        if digest != manifest['archive_sha256']:
            raise SystemExit('Upstream archive checksum mismatch; nothing was applied.')
        extracted = temp/'extracted'
        extracted.mkdir()
        with tarfile.open(archive) as tar:
            tar.extractall(extracted, filter='data')
        roots = list(extracted.iterdir())
        if len(roots) != 1 or not roots[0].is_dir():
            raise SystemExit('Unexpected upstream archive layout.')
        source = roots[0]
        for name, expected in manifest['core_files_sha256'].items():
            if hashlib.sha256((source/name).read_bytes()).hexdigest() != expected:
                raise SystemExit(f'Upstream baseline mismatch: {name}')
        patch = str(ROOT/'firmware/core.patch')
        subprocess.run(['git', 'apply', '--check', patch], cwd=source, check=True)
        subprocess.run(['git', 'apply', patch], cwd=source, check=True)
        for board in ('marvin-183', 'walle-183'):
            destination = source/'main/boards'/board
            if destination.exists():
                raise SystemExit(f'Unexpected existing board: {board}')
            shutil.copytree(ROOT/'firmware/boards'/board, destination)
        shutil.copyfile(ROOT/'firmware/dependencies.lock', source/'dependencies.lock')
        shutil.copytree(ROOT/'LICENSES', source/'robot-project-licenses')
        shutil.copyfile(ROOT/'THIRD_PARTY_NOTICES.md', source/'ROBOT_THIRD_PARTY_NOTICES.md')
        shutil.move(str(source), str(out))
    print(f'Prepared: {out}')
    print('No device was accessed. Continue with the build commands in firmware/README.md.')


if __name__ == '__main__':
    main()
