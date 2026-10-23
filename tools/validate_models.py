# SPDX-License-Identifier: MIT
"""Regenerate source geometry, compare released STL files, and inspect the 3MF."""
from pathlib import Path
import argparse
import hashlib
import json
import shutil
import subprocess
import sys
import tempfile
import xml.etree.ElementTree as ET
import zipfile
import trimesh

ROOT = Path(__file__).resolve().parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--report', type=Path, default=ROOT/'.build/model-validation.json')
    args = parser.parse_args()
    counts = {}
    with tempfile.TemporaryDirectory(prefix='robot-model-check-') as temp:
        temp = Path(temp)
        for robot in ('walle', 'marvin-v4'):
            folder = ROOT/'models'/robot
            source = folder if robot == 'walle' else folder/'source'
            generated = temp/robot
            subprocess.run([sys.executable, str(source/'build_model.py'), '--parameters',
                            str(source/'parameters.json'), '--out', str(generated)], check=True)
            released = folder/('stl' if robot == 'walle' else '正式零件')
            files = list(released.glob('*.stl'))
            assert len(files) == (10 if robot == 'walle' else 9)
            for p in files:
                assert digest(p) == digest(generated/'stl'/p.name), f'Source/STL mismatch: {p.name}'
                m = trimesh.load(p, force='mesh', process=True)
                assert m.is_watertight and m.is_winding_consistent and m.volume > 0
                assert len(m.split()) == 1 and abs(m.bounds[0, 2]) < 1e-4
            counts[robot] = len(files)
        marvin = ROOT/'models/marvin-v4'
        accessories = temp/'accessories'
        subprocess.run([sys.executable, str(marvin/'source/build_accessories.py'),
                        '--out', str(accessories)], check=True)
        files = list((marvin/'备用垫片').glob('*.stl'))
        assert len(files) == 6
        for p in files:
            assert digest(p) == digest(accessories/p.name), f'Accessory mismatch: {p.name}'
        plate_folder = temp/'plate'
        plate_folder.mkdir()
        shutil.copytree(marvin/'正式零件', plate_folder/'正式零件')
        shutil.copytree(accessories, plate_folder/'备用垫片')
        subprocess.run([sys.executable, str(marvin/'source/build_plate.py'),
                        '--model-dir', str(plate_folder)], check=True)
        name = '一次打印排版_180mm.3mf'
        with zipfile.ZipFile(marvin/name) as released, zipfile.ZipFile(plate_folder/name) as rebuilt:
            assert released.testzip() is None and rebuilt.testzip() is None
            xml = released.read('3D/3dmodel.model')
            assert xml == rebuilt.read('3D/3dmodel.model'), '3MF geometry or placement differs'
        ns = {'m': 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'}
        model = ET.fromstring(xml)
        assert model.attrib['unit'] == 'millimeter'
        assert len(model.find('m:resources', ns)) == 15
        assert len(model.find('m:build', ns)) == 20
        plate = trimesh.load(marvin/name)
        assert len(plate.geometry) == 15 and len(plate.graph.nodes_geometry) == 20
        assert all(m.is_watertight for m in plate.geometry.values())
        assert max(plate.bounds[1, :2]) < 180
    report = {'source_regeneration_stl_bytes_identical': True,
              'watertight_single_component_z0_checked': True,
              'walle_stl_count': counts['walle'], 'marvin_main_stl_count': counts['marvin-v4'],
              'marvin_accessory_stl_count': len(files), 'marvin_3mf_unique_meshes': 15,
              'marvin_3mf_print_instances': 20, 'marvin_3mf_rebuilt_geometry_identical': True,
              'physical_marvin_fit_verified': False, 'printer_slicing_verified': False}
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
