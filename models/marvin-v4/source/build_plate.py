# SPDX-License-Identifier: MIT
# Copyright (c) 2026 samaritan1998 and contributors
"""Build a machine-neutral 3MF with all one-batch quantities on a 180mm layout."""
from pathlib import Path
import argparse
import json
import xml.etree.ElementTree as E
import zipfile
import numpy as np
import trimesh

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('--model-dir',type=Path,default=Path(__file__).resolve().parents[1])
OUT=parser.parse_args().model_dir.resolve()
NS='http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
E.register_namespace('',NS)
def node(tag,**attributes):return E.Element('{'+NS+'}'+tag,{k:str(v) for k,v in attributes.items()})
model=node('model',unit='millimeter')
meta=node('metadata',name='Title');meta.text='Marvin V4 - one-batch friend print';model.append(meta)
resources=node('resources');model.append(resources)
build=node('build');model.append(build)
entries=[]
for p in sorted((OUT/'正式零件').glob('*.stl')):entries.append((p,1))
extra=json.loads((OUT/'备用垫片/accessories.json').read_text())
for name,data in extra.items():entries.append((OUT/'备用垫片'/(name+'.stl'),data['quantity']))
meshes={};placements=[]
for i,(path,qty) in enumerate(entries,1):
    m=trimesh.load(path,force='mesh',process=True)
    meshes[i]=m
    obj=node('object',id=i,type='model',name=path.stem)
    mesh=node('mesh');vertices=node('vertices');triangles=node('triangles')
    for v in m.vertices:vertices.append(node('vertex',x=format(v[0],'.9g'),y=format(v[1],'.9g'),z=format(v[2],'.9g')))
    for f in m.faces:triangles.append(node('triangle',v1=f[0],v2=f[1],v3=f[2]))
    mesh.extend([vertices,triangles]);obj.append(mesh);resources.append(obj)
    for copy in range(qty):placements.append({'id':i,'path':str(path.relative_to(OUT)), 'copy':copy+1})

placements.sort(key=lambda p:(-meshes[p['id']].extents[1],-meshes[p['id']].extents[0]))
x=y=5.;row_height=0.;rectangles=[]
for p in placements:
    m=meshes[p['id']];w,h=m.extents[:2]
    if x+w>175:
        x=5.;y+=row_height+5.;row_height=0.
    assert y+h<=175,('layout exceeds 180mm',p)
    rect=(x,y,x+w,y+h)
    for r in rectangles:
        assert not (rect[0]<r[2] and r[0]<rect[2] and rect[1]<r[3] and r[1]<rect[3])
    rectangles.append(rect)
    t=np.array([x,y,0.])-m.bounds[0]
    transform='1 0 0 0 1 0 0 0 1 '+' '.join(format(a,'.9g') for a in t)
    build.append(node('item',objectid=p['id'],transform=transform))
    p.update(translation_mm=t.tolist(),bbox_layout_mm=[*rect,float(m.extents[2])])
    x+=w+5.;row_height=max(row_height,h)

types='''<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/></Types>'''
rels='''<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>'''
path=OUT/'一次打印排版_180mm.3mf'
with zipfile.ZipFile(path,'w',zipfile.ZIP_DEFLATED) as z:
    z.writestr('[Content_Types].xml',types);z.writestr('_rels/.rels',rels)
    z.writestr('3D/3dmodel.model',E.tostring(model,encoding='utf-8',xml_declaration=True))
with zipfile.ZipFile(path) as z:
    assert z.testzip() is None
    root=E.fromstring(z.read('3D/3dmodel.model'))
    assert root.attrib['unit']=='millimeter'
    assert len(root.find('{'+NS+'}build'))==20
report={'date':'2026-10-23','unique_print_files':len(entries),'print_instances':len(placements),
        'layout_max_mm':[max(r[2] for r in rectangles),max(r[3] for r in rectangles)],
        'machine_profile_or_supports_included':False,'items':placements}
(OUT/'打印数量与排版.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
print(path.name,report['unique_print_files'],report['print_instances'],report['layout_max_mm'])
