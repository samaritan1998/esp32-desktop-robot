# SPDX-License-Identifier: MIT
# Copyright (c) 2026 samaritan1998 and contributors
"""Create the one-batch accessories; the main V4 robot geometry stays unchanged."""
from pathlib import Path
import argparse
import json
import runpy
import sys
import tempfile
import hashlib
import trimesh

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--out',type=Path,default=Path(__file__).resolve().parents[1]/'备用垫片')
args=parser.parse_args()
out=args.out.resolve();out.mkdir(parents=True,exist_ok=True)
source=Path(__file__).resolve().parent
saved=sys.argv[:]
with tempfile.TemporaryDirectory() as temp:
    sys.argv=[str(source/'build_model.py'),'--parameters',str(source/'parameters.json'),'--out',temp]
    try:g=runpy.run_path(str(source/'build_model.py'))
    finally:sys.argv=saved

parts={}
for thickness in (0.6,1.0,1.4,1.8,2.2):
    name='spacer_'+str(thickness).replace('.','p')+'mm'
    parts[name]=(g['cube']((24,4,thickness)),2)
original=g['P']['neck_pin_d'];g['P']['neck_pin_d']=5.8
parts['09b_neck_loose_5p8']=(g['make_neck'](),1)
g['P']['neck_pin_d']=original
report={}
for name,(part,quantity) in parts.items():
    mesh=g['as_trimesh'](g['place_on_bed'](part,(0,0,0)))
    assert mesh.is_watertight and mesh.is_winding_consistent and mesh.volume>0
    p=out/(name+'.stl');mesh.export(p)
    m=trimesh.load(p,force='mesh',process=True)
    assert m.is_watertight and len(m.split())==1 and abs(m.bounds[0,2])<1e-5
    report[name]={'quantity':quantity,'sha256':hashlib.sha256(p.read_bytes()).hexdigest(),
                  'bbox_mm':m.extents.round(4).tolist(),'volume_mm3':round(m.volume,3),
                  'watertight':True,'components':1,'z_min_mm':float(m.bounds[0,2])}
(out/'accessories.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print('Six accessory files ready; print two of each spacer and one alternate neck.')
