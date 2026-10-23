# SPDX-License-Identifier: MIT
# Copyright (c) 2026 samaritan1998 and contributors
"""Build a compact, static WALL-E-inspired desktop enclosure.

Dimensions in millimetres. All CSG operations also emit matching OpenSCAD.
Requires numpy, manifold3d and trimesh. No factory mesh is redistributed.
"""
from __future__ import annotations
import json
from dataclasses import dataclass
from pathlib import Path
import argparse
from itertools import combinations
import numpy as np
import manifold3d as mf
import trimesh

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--out',type=Path,default=Path(__file__).resolve().parent/'regenerated')
parser.add_argument('--parameters',type=Path,default=None)
ARGS = parser.parse_args()
OUT = ARGS.out.resolve()
OUT.mkdir(parents=True, exist_ok=True)
STL = OUT / "stl"
STL.mkdir(exist_ok=True)
FN = 64

# Nominal stock case: 44.2 wide x 37.2 high x 19.0 deep in landscape.
# The generous corner pocket does not rely on an undocumented case radius.
P = dict(case_w=44.2, case_h=37.2, case_d=19.0,
         case_clearance=0.30, window_w=36.5, window_h=31.1,
         head_w=54.0, head_h=43.0, head_d=26.0,
         body_w=50.0, body_d=34.0, body_h=34.0,
         wall=2.4, neck_pin_d=6.2, neck_socket_d=6.5,
         track_pin_d=4.0, track_socket_d=4.4,
         arm_pin_d=4.2, arm_socket_d=4.6,
         screw_pilot_d=1.7, screw_clear_d=2.4)
if ARGS.parameters:
    P.update(json.loads(ARGS.parameters.read_text(encoding='utf-8')))

def js(v): return json.dumps(v, separators=(",", ":"))

@dataclass
class CSG:
    mesh: mf.Manifold
    source: str
    def move(self, v):
        return CSG(self.mesh.translate(v), f"translate({js(list(v))}) {{\n{self.source}\n}}")
    def rotate(self, v):
        return CSG(self.mesh.rotate(v), f"rotate({js(list(v))}) {{\n{self.source}\n}}")
    def mirror(self, v):
        return CSG(self.mesh.mirror(v), f"mirror({js(list(v))}) {{\n{self.source}\n}}")

def cube(size, at=(0,0,0)):
    return CSG(mf.Manifold.cube(size, center=True), f"cube({js(list(size))},center=true);").move(at)

def cyl(d, h, at=(0,0,0), axis="z", fn=FN):
    part = CSG(mf.Manifold.cylinder(h, d/2, circular_segments=fn, center=True),
               f"cylinder(d={d},h={h},center=true,$fn={fn});")
    if axis == "x": part = part.rotate((0,90,0))
    if axis == "y": part = part.rotate((90,0,0))
    return part.move(at)

def round_prism(w, h, d, r, at=(0,0,0), plane="xy"):
    cross = mf.CrossSection.square((w-2*r,h-2*r), center=True).offset(r, circular_segments=FN)
    mesh = cross.extrude(d).translate((0,0,-d/2))
    text = f"linear_extrude(height={d},center=true) offset(r={r},$fn={FN}) square([{w-2*r},{h-2*r}],center=true);"
    shape = CSG(mesh, text)
    if plane == "xz": shape = shape.rotate((90,0,0))
    if plane == "yz": shape = shape.rotate((90,0,90))
    return shape.move(at)

def poly_yz(points, width):
    # Start with a yz cross-section, extrude along x.
    if points[0] == points[-1]: points = points[:-1]
    area2 = sum(a[0]*b[1]-b[0]*a[1] for a,b in zip(points,points[1:]+points[:1]))
    if area2 < 0: points = list(reversed(points))
    cross = mf.CrossSection([points])
    shape = cross.extrude(width).translate((0,0,-width/2)).rotate((90,0,90))
    return CSG(shape, f"rotate([90,0,90]) linear_extrude(height={width},center=true) polygon({js(points)});")

def boolean(kind, *parts):
    op = {"union":mf.OpType.Add,"difference":mf.OpType.Subtract,"intersection":mf.OpType.Intersect}[kind]
    return CSG(mf.Manifold.batch_boolean([p.mesh for p in parts], op),
               f"{kind}() {{\n" + "\n".join(p.source for p in parts) + "\n}")

def union(*p): return boolean("union", *p)
def cut(a,*p): return boolean("difference",a,*p)
def intersect(*p): return boolean("intersection",*p)

def hull(*p):
    return CSG(mf.Manifold.batch_hull([a.mesh for a in p]),
               "hull() {\n" + "\n".join(a.source for a in p) + "\n}")

def make_body():
    # Global bottom=10, top=44; rear opening at +Y. Front relief is recessed.
    outer = round_prism(P['body_w'],P['body_h'],P['body_d'],3, (0,0,27),"xz")
    cavity = round_prism(45.2,29.2,34,1.5,(0,2.4,27),"xz")
    shell = cut(outer,cavity)
    posts = [cyl(6.0,9.0,(x,12.5,z),"y") for x in (-21,21) for z in (14,40)]
    shell = union(shell,*posts)
    pilots = [cyl(P['screw_pilot_d'],8.2,(x,13.0,z),"y") for x in (-21,21) for z in (14,40)]
    sockets = [cyl(P['track_socket_d'],6,(x,y,14),"x") for x in (-24,24) for y in (-10,10)]
    sockets += [cyl(P['arm_socket_d'],6,(x,-7,35),"x") for x in (-24,24)]
    neck = cube((10.5,8.5,4),(0,9,43))
    # Shallow chest panel and three shallow vents: the front wall stays sealed.
    relief = round_prism(35,20,0.9,2,(0,-16.9,28.5),"xz")
    vents = [round_prism(7,1.2,1.0,0.5,(x,-16.9,40),"xz") for x in (-10,0,10)]
    # Cable notch in rear wall; main USB lead exits the head externally.
    cable = cube((10,6,4),(0,17,12.0))
    usb_well = round_prism(18,12,5,1.2,(0,-2.5,44))
    return cut(shell,*pilots,*sockets,neck,relief,*vents,cable,usb_well)

def make_body_cover():
    plate = round_prism(50,34,2.4,3,(0,18.2,27),"xz")
    holes = [cyl(P['screw_clear_d'],4,(x,18.2,z),"y") for x in (-21,21) for z in (14,40)]
    vents = [round_prism(18,1.8,4,0.8,(0,18.2,z),"xz") for z in (24,28,32)]
    notch = cube((10,5,4),(0,18.2,12))
    return cut(plate,*holes,*vents,notch)

def make_track(right=True):
    # Treads and rollers are cosmetic, fused into one watertight solid.
    track = hull(cyl(16,14,(32,-16,8),"x"),cyl(16,14,(32,16,8),"x"))
    cuts = []
    for y in np.arange(-14,14.1,3.5):
        cuts.append(cube((15,0.85,0.8),(32,float(y),15.8)))
    # Engraved outer side rollers and hub rings.
    for y in (-14,0,14):
        ring = cut(cyl(11.0,1.4,(38.7,y,8),"x"), cyl(5.0,2,(38.7,y,8),"x"))
        cuts.append(ring)
        cuts.append(cyl(1.8,1.2,(38.9,y,8),"x"))
    track = cut(track,*cuts)
    pegs = [cyl(P['track_pin_d'],4.0,(23.4,y,14),"x") for y in (-10,10)]
    # Pins overlap the tread by 0.4 mm; the body-facing root must stay round.
    track = union(track,*pegs)
    return track if right else track.mirror((1,0,0))

def make_arm(right=True):
    arm = round_prism(7,18,7,2,(29.5,-7,31),"xz")
    shoulder = cyl(7,6,(28,-7,35),"x")
    pin = cyl(P['arm_pin_d'],4.5,(23.75,-7,35),"x")
    palm = round_prism(7,5,7,1.2,(29.5,-8,22.5),"xz")
    fingers = [cube((2.4,9,3.2),(29.5+dx,-13,21.6)) for dx in (-2.3,2.3)]
    arm = union(arm,shoulder,pin,palm,*fingers)
    return arm if right else arm.mirror((1,0,0))

def make_neck():
    key = cube((10,8,3),(0,9,42.5))
    stop = cube((12,10,1),(0,9,44.5))
    stem = round_prism(8,6,6,1,(0,9,48))
    # Stem rounded in XY and vertical; cap peg permits manual head yaw.
    peg = cyl(P['neck_pin_d'],3.0,(0,9,52.5))
    return union(key,stop,stem,peg)

def head_base():
    center_z = 76.5
    outer = round_prism(P['head_w'],P['head_h'],P['head_d'],5.8,(0,0,center_z),"xz")
    cw = P['case_w'] + 2*P['case_clearance']
    ch = P['case_h'] + 2*P['case_clearance']
    # Front seating plane=-11.4, cavity open all the way to the rear.
    pocket = round_prism(cw,ch,24.5,5.5,(0,0.85,center_z),"xz")
    window = round_prism(P['window_w'],P['window_h'],5,5.1,(0,-12.5,center_z),"xz")
    head = cut(outer,pocket,window)
    # Rear screw columns lie in the unused rounded corners of the pocket.
    posts = [cyl(5.2,8.6,(x,8.7,center_z+dz),"y") for x in (-24,24) for dz in (-18,18)]
    head = intersect(union(head,*posts),outer)
    pilots = [cyl(P['screw_pilot_d'],8.2,(x,9,center_z+dz),"y") for x in (-24,24) for dz in (-18,18)]
    # Broad underside port/button opening, not a guess at individual USB holes.
    access = cube((36,14.4,6.2),(0,-3.5,55.9))
    return cut(head,*pilots,access)

def make_head():
    head = head_base()
    # The underside yaw boss has a 45-degree ramp for printing face-down.
    boss = poly_yz([[1,55.2],[13,55.2],[13,51],[5.2,51],[1,55.2]],12)
    head = union(head,boss)
    socket = cyl(P['neck_socket_d'],3.7,(0,9,52.75))
    return cut(head,socket)

def make_head_cover():
    cover = round_prism(54,43,2.4,5.8,(0,14.2,76.5),"xz")
    holes = [cyl(P['screw_clear_d'],4,(x,14.2,76.5+dz),"y") for x in (-24,24) for dz in (-18,18)]
    vents = [round_prism(18,1.6,4,0.7,(0,14.2,76.5+dz),"xz") for dz in (-5,0,5)]
    cover = cut(cover,*holes,*vents)
    # Four contact pads stop 0.8 mm short of the nominal case rear face.
    # Apply ~1 mm foam tape: cover must not press on bare PCB or glass.
    pads = [cube((4,4.6,4),(x,10.7,76.5+dz)) for x in (-12,12) for dz in (-9,9)]
    return union(cover,*pads)

def make_coupon():
    # Six millimetres of the actual bezel, including its case pocket and window.
    return intersect(head_base(),cube((60,6,48),(0,-10,76.5)))

def as_trimesh(part):
    raw = part.mesh.to_mesh()
    return trimesh.Trimesh(np.asarray(raw.vert_properties)[:,:3],np.asarray(raw.tri_verts),process=False)

def place_on_bed(part, rotation):
    shape = part.rotate(rotation)
    x0,y0,z0,x1,y1,z1 = shape.mesh.bounding_box()
    return shape.move((-(x0+x1)/2,-(y0+y1)/2,-z0))

PARTS = {
    '01_body_shell': (make_body(), (90,0,0), '#D8A23E'),
    '02_body_back': (make_body_cover(),(-90,0,0),'#D8A23E'),
    '03_track_left': (make_track(False),(0,0,0),'#3D4248'),
    '04_track_right': (make_track(True),(0,0,0),'#3D4248'),
    '05_arm_left': (make_arm(False),(0,-90,0),'#D8A23E'),
    '06_arm_right': (make_arm(True),(0,90,0),'#D8A23E'),
    '07_neck': (make_neck(),(0,0,0),'#525B61'),
    '08_head_shell': (make_head(),(90,0,0),'#BEC3C8'),
    '09_head_back': (make_head_cover(),(-90,0,0),'#BEC3C8'),
    '10_fit_coupon': (make_coupon(),(90,0,0),'#BEC3C8'),
}

def build():
    validation = {'units':'mm','parameters':P,'parts':{},'interference':{}}
    assembly = []
    scad = ['// SPDX-License-Identifier: CC-BY-SA-4.0\n// Copyright (c) 2026 samaritan1998 and contributors\n// Third-party character and trademark rights are not granted.\n', '// BoxBot 1.83: original WALL-E-inspired STATIC enclosure. Units: mm.',
            '// Factory black case stays intact, rotated landscape with USB/buttons downward.',
            '// This is a first fit prototype; print fit_coupon before the full head.',
            '// Source generated from the same CSG construction as the supplied STLs.',
            '$fn=64;', 'part="assembly"; // [assembly,print_layout,01_body_shell,02_body_back,03_track_left,04_track_right,05_arm_left,06_arm_right,07_neck,08_head_shell,09_head_back,10_fit_coupon]',
            'explode=0; // [0:25]', 'show_case=true;']
    for name,(part,rot,color) in PARTS.items():
        status = str(part.mesh.status())
        comps = len(part.mesh.decompose())
        printable = place_on_bed(part,rot)
        mesh = as_trimesh(printable)
        assert 'NoError' in status, (name,status)
        assert comps == 1, (name,'disconnected',comps)
        assert mesh.is_watertight and mesh.is_winding_consistent and mesh.volume > 0, name
        mesh.export(STL/f'{name}.stl')
        validation['parts'][name] = dict(status=status,components=comps,watertight=bool(mesh.is_watertight),
                winding_consistent=bool(mesh.is_winding_consistent),triangles=len(mesh.faces),
                bbox_print_mm=np.round(mesh.bounds,4).tolist(),volume_mm3=round(mesh.volume,2),
                print_rotation_deg=rot)
        scad.append(f'module m_{name}() {{\n{part.source}\n}}')
        # Export assembly-position meshes for reproducible previews and fit checks.
        if name != '10_fit_coupon':
            assembly.append(as_trimesh(part))
        print(name,comps,len(mesh.faces),np.round(mesh.extents,2).tolist(),flush=True)
    joined = trimesh.util.concatenate(assembly)
    joined.export(OUT/'assembly_preview.stl')
    validation['assembled_size_mm'] = np.round(joined.extents,3).tolist()
    # Stock case exclusion volume is rectangular and conservative at its corners.
    stock = round_prism(P['case_w'],P['case_h'],P['case_d'],7.5,(0,-1.9,76.5),'xz')
    for name in ('08_head_shell','09_head_back'):
        overlap = (PARTS[name][0].mesh ^ stock.mesh).volume()
        validation['interference'][f'{name}_versus_stock_case_mm3'] = round(overlap,6)
        assert overlap < 0.001, (name,'stock case interference',overlap)
    assembly_names = [n for n in PARTS if n!='10_fit_coupon']
    for a,b in combinations(assembly_names,2):
        overlap = (PARTS[a][0].mesh ^ PARTS[b][0].mesh).volume()
        validation['interference'][f'{a}_versus_{b}_mm3'] = round(overlap,6)
        assert overlap < 0.001, (a,b,'interference',overlap)
    scad.append('module assembled() {')
    for i,(name,(_,_,color)) in enumerate(PARTS.items()):
        if name == '10_fit_coupon': continue
        shift = [0,0,0]
        if name=='02_body_back': shift=[0,1,0]
        if 'track_left' in name or 'arm_left' in name: shift=[-1,0,0]
        if 'track_right' in name or 'arm_right' in name: shift=[1,0,0]
        if name=='07_neck': shift=[0,0,0.4]
        if name=='08_head_shell': shift=[0,0,1]
        if name=='09_head_back': shift=[0,1,1]
        scad.append(f'color("{color}") translate([{shift[0]}*explode,{shift[1]}*explode,{shift[2]}*explode]) m_{name}();')
    scad.append('if(show_case) color("#15191D") translate([0,0,explode]) stock_case_preview();\n}')
    scad.append(f'module stock_case_preview() {{\n{stock.source}\n}}')
    scad.append('module print_layout() {')
    for i,(name,(part,rot,color)) in enumerate(PARTS.items()):
        ready = place_on_bed(part,rot)
        scad.append(f'translate([{(i%3)*70},{(i//3)*62},0]) {{\n{ready.source}\n}}')
    scad.append('}')
    scad.append('if(part=="assembly") assembled(); else if(part=="print_layout") print_layout();')
    for name,(part,rot,color) in PARTS.items():
        ready = place_on_bed(part,rot)
        scad.append(f'else if(part=="{name}") {{\n{ready.source}\n}}')
    (OUT/'boxbot.scad').write_text('\n\n'.join(scad),encoding='utf-8')
    (OUT/'validation.json').write_text(json.dumps(validation,indent=2),encoding='utf-8')
    (OUT/'parameters.json').write_text(json.dumps(P,indent=2),encoding='utf-8')
    np.savez(OUT/'assembly_mesh_data.npz',
        **{name+'_vertices':as_trimesh(part).vertices for name,(part,_,_) in PARTS.items() if name!='10_fit_coupon'},
        **{name+'_faces':as_trimesh(part).faces for name,(part,_,_) in PARTS.items() if name!='10_fit_coupon'},
        case_vertices=as_trimesh(stock).vertices,case_faces=as_trimesh(stock).faces)
    print('Assembly size:',validation['assembled_size_mm'],flush=True)

if __name__=='__main__': build()
