# SPDX-License-Identifier: MIT
# Copyright (c) 2026 samaritan1998 and contributors
"""Build the Marvin v4 enclosure and full-depth assembly trial sleeve.

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

# Drawing dimensions describe the nominal shell, not a measured user sample.
# The separate design envelope reserves room for controls and shell variation.
# Physical validation with the trial sleeve is still required.
P = dict(nominal_case_w=44.2, nominal_case_h=37.2, nominal_case_d=19.0,
         case_w=46.0, case_h=40.0, case_d=21.0,
         case_clearance=0.80, window_w=36.5, window_h=31.1,
         head_w=84.0, head_h=60.0, head_d=84.0,
         wall=2.4, neck_pin_d=6.2, neck_socket_d=6.5,
         leg_pin_d=6.2, leg_socket_d=6.5,
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
    def scale(self, v):
        return CSG(self.mesh.scale(v), f"scale({js(list(v))}) {{\n{self.source}\n}}")

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

def sphere(r,at=(0,0,0),fn=64):
    return CSG(mf.Manifold.sphere(r,circular_segments=fn),f"sphere(r={r},$fn={fn});").move(at)

def ellipsoid(size,at=(0,0,0)):
    return sphere(1,fn=128).scale(tuple(v/2 for v in size)).move(at)

def soft_box(size,r,at=(0,0,0)):
    corners=[]
    for sx in (-1,1):
        for sy in (-1,1):
            for sz in (-1,1):
                corners.append(sphere(r,(sx*(size[0]/2-r),sy*(size[1]/2-r),sz*(size[2]/2-r)),fn=48))
    return hull(*corners).move(at)

HZ=70.0
FRONT_Y=-15.0
CASE_FRONT=-13.4
SEAM_Y=14.5
HEAD_SCREW_X=29.5
HEAD_SCREW_Z=6.0
P.update(revision='marvin-fit-v4', head_screw_x=HEAD_SCREW_X, head_screw_z=HEAD_SCREW_Z, passage_corner_radius=0.0)

def head_outer():
    # A true ellipsoid, flattened at front/back to form printable seating faces.
    dome=ellipsoid((P['head_w'],P['head_d'],P['head_h']),(0,0,HZ))
    return intersect(dome,cube((100,39,100),(0,4.5,HZ))) # Y=-15..24

def head_inner():
    inside=ellipsoid((P['head_w']-4.8,P['head_d']-4.8,P['head_h']-4.8),(0,0,HZ))
    # Leave 1.6 mm at the front flat, 2.4 mm at the rear flat.
    return intersect(inside,cube((100,35.0,100),(0,4.1,HZ))) # Y=-13.4..21.6

def make_head_front(include_socket=True):
    outer=head_outer()
    shell=cut(outer,head_inner())
    cw=P['case_w']+2*P['case_clearance']
    ch=P['case_h']+2*P['case_clearance']
    # Straight rear insertion passage; square corners conservatively clear the whole nominal bounding box.
    pocket=cube((cw,80.0,ch),(0,CASE_FRONT+40.0,HZ)) # -13.4..66.6
    window=round_prism(P['window_w'],P['window_h'],4,5.1,(0,-14.0,HZ),'xz')
    front_half=cube((100,60,100),(0,-15.5,HZ)) # rear seam at 14.5
    shell=intersect(cut(shell,pocket,window),front_half)
    # Four short diagonal ribs tie the screw seats to the dome behind the case.
    ribs=[]
    for sx in (-1,1):
        for sz in (-1,1):
            ribs.append(hull(cyl(5.6,8.5,(sx*HEAD_SCREW_X,10.25,HZ+sz*HEAD_SCREW_Z),'y'),
                             cyl(5.6,8.5,(sx*34.0,10.25,HZ+sz*HEAD_SCREW_Z),'y')))
    shell=union(shell,*[intersect(r,head_outer(),front_half) for r in ribs])
    pilots=[cyl(P['screw_pilot_d'],8.8,(x,10.25,HZ+dz),'y')
            for x in (-HEAD_SCREW_X,HEAD_SCREW_X) for dz in (-HEAD_SCREW_Z,HEAD_SCREW_Z)]
    access=cube((36,16.0,16.2),(0,-4.5,46.0)) # underside USB/buttons opening
    shell=cut(shell,pocket,*pilots,access) # Passage is cut AFTER all fixed ribs are added.
    # Solid neck boss stays clear of the case and of the connector opening.
    boss=round_prism(12,10,6.6,1.5,(0,9,43.3))
    shell=union(shell,boss)
    if include_socket:
        shell=cut(shell,cyl(P['neck_socket_d'],3.8,(0,9,41.8)))
    # Slots connect the microphone edge to outside air. Speaker vents on both
    # sides tolerate the left/right orientation of the stock case's short edge.
    microphone=[cube((2.8,12,28),(x,-4,100)) for x in (5,10,15)]
    speaker=[cube((38,10,2.4),(sx*40,-4.5,HZ+dz))
             for sx in (-1,1) for dz in (-5,0,5)]
    return cut(shell,*microphone,*speaker)

def make_head_back():
    cap=intersect(cut(head_outer(),head_inner()),cube((100,30,100),(0,29.5,HZ))) # Y>=14.5
    # Flat seats for 2 mm screws, independent of the curved dome.
    seats=[intersect(hull(cyl(5.6,4.0,(sx*HEAD_SCREW_X,16.5,HZ+dz),'y'),
                          cyl(5.6,4.0,(sx*37.0,16.5,HZ+dz),'y')),head_outer())
           for sx in (-1,1) for dz in (-HEAD_SCREW_Z,HEAD_SCREW_Z)]
    cap=union(cap,*seats)
    holes=[cyl(P['screw_clear_d'],13,(x,19.0,HZ+dz),'y')
           for x in (-HEAD_SCREW_X,HEAD_SCREW_X) for dz in (-HEAD_SCREW_Z,HEAD_SCREW_Z)]
    # Recess the screw heads rather than adding protruding exterior ears.
    counterbores=[cyl(5.0,7.0,(x,22.0,HZ+dz),'y')
                 for x in (-HEAD_SCREW_X,HEAD_SCREW_X) for dz in (-HEAD_SCREW_Z,HEAD_SCREW_Z)]
    # Pads end 0.8 mm behind the conservative 21 mm case envelope. The nominal
    # 19 mm case needs about 3 mm foam; select thickness by actual dry closure.
    pad_front=CASE_FRONT+P['case_d']+0.8
    pads=[intersect(cube((4,13.5,4),(x,pad_front+6.75,HZ+dz)),head_outer())
          for x in (-10,10) for dz in (-9,9)]
    cap=union(cap,*pads)
    # Rear vents avoid the retention pads and are visible only from behind.
    vents=[round_prism(12,1.6,10,0.7,(0,22,HZ+dz),'xz') for dz in (-4,0,4)]
    return cut(cap,*holes,*counterbores,*vents)

def make_body():
    outer=soft_box((34,24,22),6,(0,3,25))
    outer=intersect(outer,cube((60,60,60),(0,-18,25))) # cut rear at Y=12
    inner=soft_box((29.2,19.2,17.2),3.6,(0,3,25))
    rear_open=round_prism(29.2,17.2,12,3.6,(0,15,25),'xz')
    body=cut(outer,inner,rear_open)
    posts=[cyl(6.2,6.0,(x,9,25+dz),'y') for x in (-12,12) for dz in (-6,6)]
    body=intersect(union(body,*posts),outer)
    holes=[cyl(P['screw_pilot_d'],6.3,(x,9,25+dz),'y') for x in (-12,12) for dz in (-6,6)]
    shoulder=[cyl(P['arm_socket_d'],7,(x,3,31),'x') for x in (-15,15)]
    legs=[cyl(P['leg_socket_d'],4,(x,2,15.7)) for x in (-10,10)]
    neck=cube((10.5,8.5,4.1),(0,9,34.1))
    badge=round_prism(12,5,1.2,2.0,(0,-8.8,27.5),'xz')
    # A roof/front opening gives a straight USB boot room when lowering the
    # pre-connected head onto its neck. It leaves the neck key and badge intact.
    usb_chase=cube((16,16,10),(0,-4,36.5))
    return cut(body,*holes,*shoulder,*legs,neck,badge,usb_chase)

def make_body_back():
    cover=round_prism(32,20,2.4,5,(0,13.2,25),'xz')
    holes=[cyl(P['screw_clear_d'],4,(x,13.2,25+dz),'y') for x in (-12,12) for dz in (-6,6)]
    neck_notch=cube((10.5,4,4),(0,13.2,34.1))
    vents=[round_prism(10,1.4,4,0.6,(0,13.2,z),'xz') for z in (23,26)]
    return cut(cover,*holes,neck_notch,*vents)

def make_foot(right=True):
    x=11.0
    shoe=soft_box((20,40,10),4.5,(x,-4,5))
    shin=cyl(7.4,5.0,(10,2,11.0)) # 8.5..13.5, fused into shoe
    stop=cyl(8.8,2,(10,2,13))
    pin=cyl(P['leg_pin_d'],3.0,(10,2,15.5))
    toe_groove=round_prism(13,0.65,2.8,0.30,(x,-24.0,5.2),'xz')
    foot=cut(union(shoe,shin,stop,pin),toe_groove)
    return foot if right else foot.mirror((1,0,0))

def make_arm(right=True):
    shoulder=sphere(4.5,(21.5,3,31),fn=64)
    upper=hull(sphere(3.5,(21.5,3,29.5),fn=48),sphere(3.5,(23.5,3,21.5),fn=48))
    hand=soft_box((8,9,7),3,(23.5,2,17.8))
    pin=cyl(P['arm_pin_d'],5.6,(15.8,3,31),'x')
    arm=union(shoulder,upper,hand,pin)
    finger_grooves=[cube((0.6,1.0,3.6),(23.5+dx,-2.3,17.8)) for dx in (-1.6,1.6)]
    arm=cut(arm,*finger_grooves)
    return arm if right else arm.mirror((1,0,0))

def make_neck():
    key=cube((10,8,3),(0,9,34.5)) # 33..36
    stop=cube((12,10,1),(0,9,36.5))
    shaft=round_prism(8,6,3,1,(0,9,38.5))
    peg=cyl(P['neck_pin_d'],3,(0,9,41.5))
    return union(key,stop,shaft,peg)

def make_coupon():
    # Exact six millimetres of the screen seating area, not a generic size gauge.
    return intersect(make_head_front(),cube((60,6,48),(0,-12,HZ)))

def make_entry_gauge():
    # A 3 mm thick through-ring for checking the full case envelope before printing a head.
    cw=P['case_w']+2*P['case_clearance']
    ch=P['case_h']+2*P['case_clearance']
    return cut(round_prism(cw+6,ch+6,3,3),cube((cw,ch,5)))

def make_trial_sleeve():
    """Continuous four-wall gauge plus exact front ledge and rear screw datum.

    The sleeve deliberately constrains more of the case than the finished head.
    Same rear cap, same screw seats and same front plane; it checks depth and
    USB access in addition to the complete insertion path.
    """
    cw=P['case_w']+2*P['case_clearance']
    ch=P['case_h']+2*P['case_clearance']
    depth=SEAM_Y-FRONT_Y
    outer=cube((cw+2.8,depth,ch+2.8),(0,(FRONT_Y+SEAM_Y)/2,HZ))
    pocket=cube((cw,80,ch),(0,CASE_FRONT+40,HZ))
    window=round_prism(P['window_w'],P['window_h'],4,5.1,(0,-14,HZ),'xz')
    ears=[]
    for sx in (-1,1):
        for sz in (-1,1):
            ears.append(hull(cyl(5.6,8.5,(sx*HEAD_SCREW_X,10.25,HZ+sz*HEAD_SCREW_Z),'y'),
                             cyl(5.6,8.5,(sx*(cw/2+0.7),10.25,HZ+sz*HEAD_SCREW_Z),'y')))
    holes=[cyl(P['screw_pilot_d'],8.8,(x,10.25,HZ+dz),'y')
           for x in (-HEAD_SCREW_X,HEAD_SCREW_X) for dz in (-HEAD_SCREW_Z,HEAD_SCREW_Z)]
    access=cube((36,16,16.2),(0,-4.5,46))
    return cut(union(outer,*ears),pocket,window,access,*holes)

def as_trimesh(part):
    raw=part.mesh.to_mesh()
    return trimesh.Trimesh(np.asarray(raw.vert_properties)[:,:3],np.asarray(raw.tri_verts),process=False)

def place_on_bed(part,rotation):
    part=part.rotate(rotation)
    x0,y0,z0,x1,y1,z1=part.mesh.bounding_box()
    return part.move((-(x0+x1)/2,-(y0+y1)/2,-z0))

PARTS={
    '01_head_front':(make_head_front(),(90,0,0),'#E4E6E8'),
    '02_head_back':(make_head_back(),(-90,0,0),'#E4E6E8'),
    '03_body_shell':(make_body(),(90,0,0),'#E4E6E8'),
    '04_body_back':(make_body_back(),(-90,0,0),'#E4E6E8'),
    '05_arm_left':(make_arm(False),(0,-90,0),'#E4E6E8'),
    '06_arm_right':(make_arm(True),(0,90,0),'#E4E6E8'),
    '07_foot_left':(make_foot(False),(0,0,0),'#E4E6E8'),
    '08_foot_right':(make_foot(True),(0,0,0),'#E4E6E8'),
    '09_neck':(make_neck(),(0,0,0),'#636B73'),
    '10_fit_coupon':(make_coupon(),(90,0,0),'#E4E6E8'),
    '11_entry_gauge':(make_entry_gauge(),(0,0,0),'#E4E6E8'),
    '12_trial_sleeve':(make_trial_sleeve(),(90,0,0),'#8BA4AE'),
}

def explode_direction(name):
    if name=='01_head_front':return [0,0,1]
    if name=='02_head_back':return [0,1,1]
    if name=='04_body_back':return [0,1,0]
    if name in ('05_arm_left','07_foot_left'):return [-1,0,0]
    if name in ('06_arm_right','08_foot_right'):return [1,0,0]
    if name=='09_neck':return [0,0,.35]
    return [0,0,0]


def validate_paths(report):
    front=PARTS['01_head_front'][0].mesh
    back=PARTS['02_head_back'][0].mesh
    cw=P['case_w']+2*P['case_clearance'];ch=P['case_h']+2*P['case_clearance']
    sweep=cube((cw,P['case_d']+60,ch),(0,CASE_FRONT+(P['case_d']+60)/2,HZ)).mesh
    overlap=(front^sweep).volume()
    assert overlap<1e-5,('continuous insertion path',overlap)
    stock_box=cube((P['case_w'],P['case_d'],P['case_h']),
                   (0,CASE_FRONT+P['case_d']/2,HZ)).mesh
    for name in ('01_head_front','02_head_back'):
        v=(PARTS[name][0].mesh^stock_box).volume()
        assert v<1e-5,(name,'conservative case box',v)
        report['interference'][name+'_versus_case_box_mm3']=round(v,6)
    envelope=cube((cw,P['case_d'],ch),(0,CASE_FRONT+P['case_d']/2,HZ)).mesh
    escaped=(envelope-head_outer().mesh).volume()
    assert escaped<1e-5,('passage corners outside head exterior',escaped)
    report['case_clearance_box_outside_outer_envelope_mm3']=round(escaped,6)
    rim_probe=cube((cw+2.4,P['case_d'],ch+2.4),
                   (0,CASE_FRONT+P['case_d']/2,HZ)).mesh
    rim_escape=(rim_probe-head_outer().mesh).volume()
    assert rim_escape<1e-5,('1.2 mm corner rim envelope',rim_escape)
    report['minimum_xy_corner_rim_allowance_mm']=1.2
    tolerance_sweep=cube((P['case_w']+0.6,P['case_d']+60,P['case_h']+0.6),
                        (0,CASE_FRONT+(P['case_d']+60)/2,HZ)).mesh
    tolerance_overlap=(front^tolerance_sweep).volume()
    assert tolerance_overlap<1e-5,('0.3 mm inward print tolerance',tolerance_overlap)
    report['bounded_print_tolerance_check']={
        'assumed_inward_error_per_side_mm':0.3,
        'remaining_clearance_per_side_mm':round(P['case_clearance']-0.3,3),
        'swept_collision_mm3':round(tolerance_overlap,6),
        'scope':'Bounded geometric allowance only; does not measure a printer or replace the physical trial.'}
    report['continuous_case_insertion']={
        'translation_mm':60,'passage_width_height_mm':[cw,ch],
        'clearance_per_side_mm':P['case_clearance'],
        'swept_volume_collision_mm3':round(overlap,6),
        'direction':'Rear cover removed; centered case travels along -Y, screen first.'}
    # Every inlet, ledge and rear-cap datum in the sleeve comes from the exact
    # parameters used by the complete head. No scaled or unrelated trial model.
    sleeve=PARTS['12_trial_sleeve'][0].mesh
    sleeve_sweep=(sleeve^sweep).volume()
    assert sleeve_sweep<1e-5,('trial sleeve insertion',sleeve_sweep)
    assert (sleeve^back).volume()<1e-5,('trial sleeve rear-cap overlap',(sleeve^back).volume())
    nominal_d=P['nominal_case_d']
    pad_front=CASE_FRONT+P['case_d']+0.8
    report['trial_sleeve']={
        'same_passage_width_height_mm':[cw,ch],
        'same_screen_seating_plane_y_mm':CASE_FRONT,
        'same_rear_cap_seam_y_mm':SEAM_Y,
        'same_screw_centers_x_mm':[-HEAD_SCREW_X,HEAD_SCREW_X],
        'same_screw_centers_z_mm':[HZ-HEAD_SCREW_Z,HZ+HEAD_SCREW_Z],
        'full_depth_mm':SEAM_Y-FRONT_Y,
        'uses_actual_final_rear_cap':'02_head_back.stl',
        'swept_collision_mm3':round(sleeve_sweep,6),
        'rear_cap_interference_mm3':round((sleeve^back).volume(),6),
        'nominal_rear_foam_gap_mm':round(pad_front-(CASE_FRONT+nominal_d),3),
        'conservative_envelope_rear_foam_gap_mm':0.8,
        'scope':'Trial must be printed with the same material, scale, orientation and slicer settings as the final head.'}
    plug=cube((14,12,18),(0,-4.5,HZ-P['case_h']/2-9)).mesh
    plug_sweep=cube((14,12,48),(0,-4.5,HZ-P['case_h']/2+6)).mesh
    values={}
    for name in ('01_head_front','02_head_back','03_body_shell','04_body_back','09_neck'):
        v=(PARTS[name][0].mesh^plug).volume()
        assert v<1e-5,(name,'USB boot final',v)
        values[name]=round(v,6)
    swept={}
    for name in ('03_body_shell','04_body_back','09_neck'):
        v=(PARTS[name][0].mesh^plug_sweep).volume()
        assert v<1e-5,(name,'USB boot lowering path',v)
        swept[name]=round(v,6)
    report['usb_boot']={'assumed_box_mm':[14,12,18],
        'case_bottom_z_mm':HZ-P['case_h']/2,'collision_final_mm3':values,
        'lowering_head_by_30mm_collision_with_body_and_neck_mm3':swept,
        'assembly_order':'Connect USB to the unmounted head, then lower head onto neck; route flexible cable through front roof notch.',
        'scope':'Checks this nominal straight plug envelope only; actual cable boot must be compared before printing.'}
    v=(sleeve^plug).volume()
    assert v<1e-5,('trial sleeve USB boot',v)
    report['trial_sleeve']['usb_boot_interference_mm3']=round(v,6)
    channels={}
    for x in (5,10,15):
        channel=cube((2.8,12,22),(x,-4,HZ+P['case_h']/2+11)).mesh
        v=(front^channel).volume();assert v<1e-5,('microphone vent',x,v)
        channels['top_'+str(x)]=round(v,6)
    for sx in (-1,1):
        for dz in (-5,0,5):
            channel=cube((32,10,2.4),(sx*(P['case_w']/2+16),-4.5,HZ+dz)).mesh
            v=(front^channel).volume();assert v<1e-5,('speaker vent',sx,dz,v)
            channels[f'side_{sx}_{dz}']=round(v,6)
    report['acoustic_air_corridors']={'geometric_collision_mm3':channels,
        'source':'Official 2D drawing: microphone holes on edge opposite USB/buttons; speaker slots on a short edge.',
        'scope':'Open air passages only. No acoustic seal, frequency response or physical voice quality verified.'}

def build():
    report={'revision':'marvin-fit-v4','units':'mm','physical_fit_verified':False,'physical_acoustic_verified':False,
            'measured_user_case_dimensions_available':False,
            'case_dimensions_scope':'Nominal shell from official drawing; larger conservative design envelope is an engineering allowance, not a measured user sample.',
            'parameters':P,'parts':{},'interference':{}}
    printable_names=list(PARTS)
    assembled_names=[n for n in PARTS if int(n[:2])<=9]
    joined=[]
    scad=['// SPDX-License-Identifier: CC-BY-SA-4.0\n// Copyright (c) 2026 samaritan1998 and contributors\n// Third-party character and trademark rights are not granted.\n', '// Original Marvin-inspired desktop robot enclosure, units: millimetres.',
          '// Keep the factory black case intact, landscape, USB/buttons down.',
          '// Print the fit coupon before the complete head. Physical fit untested.',
          '$fn=64;', 'part="assembly"; // ['+','.join(['assembly','print_layout']+printable_names)+']',
          'explode=0; // [0:25]','show_case=true;']
    for name,(part,rotation,color) in PARTS.items():
        printable=place_on_bed(part,rotation)
        mesh=as_trimesh(printable)
        status=str(part.mesh.status());components=len(part.mesh.decompose())
        assert 'NoError' in status,(name,status)
        assert components==1,(name,'disconnected',components)
        assert mesh.is_watertight and mesh.is_winding_consistent and mesh.volume>0,name
        path=STL/f'{name}.stl'
        mesh.export(path)
        reloaded=trimesh.load(path,force='mesh',process=True)
        assert reloaded.is_watertight and reloaded.is_winding_consistent and reloaded.volume>0
        assert len(reloaded.split())==1 and abs(reloaded.bounds[0,2])<1e-5
        import hashlib

        report['parts'][name]=dict(sha256=hashlib.sha256(path.read_bytes()).hexdigest(),reloaded_checked=True,status=status,components=components,watertight=bool(mesh.is_watertight),
            winding_consistent=bool(mesh.is_winding_consistent),triangles=len(mesh.faces),
            bbox_print_mm=np.round(mesh.bounds,4).tolist(),volume_mm3=round(mesh.volume,2),print_rotation_deg=rotation)
        if name in assembled_names:joined.append(as_trimesh(part))
        scad.append(f'module m_{name}() {{\n{part.source}\n}}')
        print(name,status,components,np.round(mesh.extents,2).tolist(),flush=True)
    assembly=trimesh.util.concatenate(joined)
    assembly.export(OUT/'assembly_preview.stl')
    report['assembled_size_mm']=np.round(assembly.extents,3).tolist()
    stock=round_prism(P['nominal_case_w'],P['nominal_case_h'],P['nominal_case_d'],7.5,(0,CASE_FRONT+P['nominal_case_d']/2,HZ),'xz')
    for name in ('01_head_front','02_head_back'):
        overlap=(PARTS[name][0].mesh ^ stock.mesh).volume()
        report['interference'][f'{name}_versus_stock_case_mm3']=round(overlap,6)
        assert overlap<.001,(name,'stock interference',overlap)
    for a,b in combinations(assembled_names,2):
        overlap=(PARTS[a][0].mesh ^ PARTS[b][0].mesh).volume()
        report['interference'][f'{a}_versus_{b}_mm3']=round(overlap,6)
        assert overlap<.001,(a,b,'interference',overlap)
    scad.append('module assembled() {')
    for name in assembled_names:
        direction=explode_direction(name)
        scad.append(f'color("{PARTS[name][2]}") translate([{direction[0]}*explode,{direction[1]}*explode,{direction[2]}*explode]) m_{name}();')
    scad.append('if(show_case) color("#15191D") translate([0,0,explode]) stock_case_preview();\n}')
    scad.append(f'module stock_case_preview() {{\n{stock.source}\n}}')
    scad.append('module print_layout() {')
    for i,(name,(part,rotation,color)) in enumerate(PARTS.items()):
        ready=place_on_bed(part,rotation)
        scad.append(f'translate([{(i%3)*82},{(i//3)*70},0]) {{\n{ready.source}\n}}')
    scad.append('}')
    scad.append('if(part=="assembly") assembled(); else if(part=="print_layout") print_layout();')
    for name,(part,rotation,color) in PARTS.items():
        scad.append(f'else if(part=="{name}") {{\n{place_on_bed(part,rotation).source}\n}}')
    (OUT/'marvin.scad').write_text('\n\n'.join(scad),encoding='utf-8')
    validate_paths(report)
    (OUT/'validation.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
    (OUT/'parameters.json').write_text(json.dumps(P,indent=2),encoding='utf-8')
    np.savez(OUT/'assembly_mesh_data.npz',
        **{n+'_vertices':as_trimesh(PARTS[n][0]).vertices for n in assembled_names},
        **{n+'_faces':as_trimesh(PARTS[n][0]).faces for n in assembled_names},
        case_vertices=as_trimesh(stock).vertices,case_faces=as_trimesh(stock).faces)
    np.savez(OUT/'trial_mesh_data.npz',
        sleeve_vertices=as_trimesh(PARTS['12_trial_sleeve'][0]).vertices,
        sleeve_faces=as_trimesh(PARTS['12_trial_sleeve'][0]).faces)
    print('Assembly size:',report['assembled_size_mm'],flush=True)

if __name__=='__main__':
    build()
