# SPDX-License-Identifier: MIT
"""Draw a close-up shim guide using the V4 cap's assembly-space mesh.

Run render_assembly_guides.py first to regenerate the mesh cache. Colored pad
faces, shims, foam and the side-view black case are explanatory overlays.
"""
from pathlib import Path
import argparse
import numpy as np
from PIL import Image, ImageDraw, ImageFont
from render_assembly_guides import ROOT, View, box

INK = '#203341'
MUTED = '#536978'
TEAL = '#147B70'
ORANGE = '#E7A441'
FOAM = '#32BBA6'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--font', type=Path, default=ROOT/'.cache/NotoSansCJKsc-Regular.otf')
    parser.add_argument('--mesh', type=Path,
                        default=ROOT/'.build/assembly-guides/marvin-v4/assembly_mesh_data.npz')
    parser.add_argument('--out', type=Path, default=ROOT/'docs/images/marvin-v4-shim-guide.png')
    args = parser.parse_args()
    if not args.mesh.exists() or not args.font.exists():
        parser.error('Supply a Noto CJK --font and regenerate the assembly mesh with render_assembly_guides.py.')
    sheet = Image.new('RGB', (1800, 2670), '#F2F5F7')
    draw = ImageDraw.Draw(sheet)

    def text(x, y, content, size=34, color=INK, anchor='lt'):
        font = ImageFont.truetype(str(args.font), size)
        draw.text((x, y), content, font=font, fill=color, anchor=anchor)

    def arrow(a, b, color=TEAL, width=6):
        a, b = np.array(a, dtype=float), np.array(b, dtype=float)
        u = (b-a)/np.linalg.norm(b-a)
        n = np.array([-u[1], u[0]])
        draw.line([tuple(a), tuple(b-u*4)], fill=color, width=width)
        draw.polygon([tuple(b), tuple(b-u*22+n*11), tuple(b-u*22-n*11)], fill=color)

    def card(y0, y1, heading):
        draw.rounded_rectangle((60, y0, 1740, y1), radius=30, fill='white')
        text(100, y0+34, heading, 47)

    text(80, 50, 'Marvin V4 · 垫片到底怎么装？', 65)
    text(84, 145, '解决屏幕黑壳在头部里前后晃动｜只拆头部后盖即可', 34, MUTED)
    draw.rounded_rectangle((85, 211, 125, 241), radius=5, fill=ORANGE)
    text(142, 210, '橙色＝打印的硬垫片', 30)
    draw.rounded_rectangle((640, 211, 680, 241), radius=5, fill=FOAM)
    text(697, 210, '绿色＝另备的软泡棉', 30)
    text(1250, 210, '颜色仅为图示', 29, MUTED)

    card(285, 1265, '1  后盖内侧：每排两个方柱，横跨一条垫片')
    text(100, 390, '① 先找到这四个小方柱', 36, TEAL)
    text(940, 390, '② 上下各贴一条，再贴软泡棉', 36, TEAL)
    data = np.load(args.mesh)
    cap = (data['02_head_back_vertices'], data['02_head_back_faces'], '#D1DBE1')

    def paste_view(parts, origin):
        view = View(parts, (790, 635), az=-90, elev=19)
        layer = view.render()
        sheet.paste(layer, tuple(int(n) for n in origin), layer)
        return lambda p: view.project(p)+origin

    bare = [cap]
    # Pad faces are Y=8.4; highlighted faces sit just toward the viewer.
    for x in (-10, 10):
        for z in (61, 79):
            bare.append(box((4, .08, 4), (x, 8.35, z), ORANGE))
    project = paste_view(bare, np.array([90, 470]))
    for n, (x, z) in enumerate([(-10, 79), (10, 79), (-10, 61), (10, 61)], 1):
        p = project([x, 8.28, z])
        badge = p+[-48 if x < 0 else 48, -40 if z > 70 else 40]
        draw.line([tuple(badge), tuple(p)], fill='#A85C16', width=4)
        r = 22
        draw.ellipse((badge[0]-r, badge[1]-r, badge[0]+r, badge[1]+r), fill='#A85C16', outline='white', width=3)
        text(badge[0], badge[1]-1, str(n), 26, 'white', 'mm')
    padded = [cap]
    for z in (61, 79):
        # 1.4 mm is for illustration only; the user selects thickness by closure.
        padded.append(box((24, 1.4, 4), (0, 7.7, z), ORANGE))
        padded.append(box((24, .8, 4), (0, 6.6, z), FOAM))
    project = paste_view(padded, np.array([920, 470]))
    for label, z, dy in [('上面一条', 79, -32), ('下面一条', 61, 40)]:
        p = project([12, 6.2, z])
        end = p+[92, dy]
        draw.line([tuple(p), tuple(end)], fill=TEAL, width=4)
        text(end[0]-10, end[1]+10, label, 29, TEAL)
    hole = project([0, 21.5, 70])
    draw.line([tuple(hole), (1135, 1114)], fill=MUTED, width=3)
    text(1020, 1125, '中间三道长孔留空', 31, MUTED)
    text(110, 1135, '拿下 02 号后盖，凹面朝自己。', 31, MUTED)
    draw.rounded_rectangle((105, 1190, 1695, 1243), radius=13, fill='#FFF2DA')
    text(131, 1200, '只装两条：上下选同一种厚度。五种规格不用全部装，也不用叠起来。', 31, '#805014')

    card(1305, 1900, '2  侧面拆开看：软泡棉接触黑壳背面')
    text(105, 1404, '屏幕正面在左边 ←                  以下是拆开示意，间距不按比例', 31, MUTED)
    # Exploded side view: case, foam, hard shim, support post and cap wall.
    draw.rounded_rectangle((160, 1495, 520, 1720), radius=26, fill='#263B46')
    draw.rounded_rectangle((172, 1515, 190, 1700), radius=7, fill='#70CBE3')
    text(340, 1595, '原装黑壳', 35, 'white', 'mm')
    draw.rounded_rectangle((700, 1495, 748, 1720), radius=7, fill=FOAM)
    for y in range(1510, 1710, 22):
        draw.line([(705, y), (742, y+9)], fill='#188D7C', width=3)
    draw.rounded_rectangle((930, 1495, 968, 1720), radius=4, fill=ORANGE)
    draw.rectangle((1160, 1555, 1440, 1660), fill='#BAC9D1', outline='#7C939F', width=3)
    draw.rounded_rectangle((1430, 1475, 1490, 1740), radius=11, fill='#D1DBE1', outline='#7C939F', width=3)
    for a, b in [(650, 565), (875, 793), (1100, 1015)]:
        arrow((a, 1608), (b, 1608))
    text(340, 1761, '黑壳背面 →', 31, INK, 'mt')
    text(724, 1761, '软泡棉', 32, TEAL, 'mt')
    text(949, 1761, '硬垫片', 32, '#9E6018', 'mt')
    text(1290, 1761, '小方柱', 32, MUTED, 'mt')
    text(1535, 1585, '后盖', 31, MUTED)
    text(105, 1835, '硬垫片用薄双面胶定位；其上贴自粘薄泡棉。泡棉需另备，约 1 mm 起试。', 31, MUTED)

    card(1940, 2475, '3  先试合盖，再调厚度')
    values = ['0.6', '1.0', '1.4', '1.8', '2.2']
    for i, value in enumerate(values):
        x = 120+i*310
        draw.rounded_rectangle((x, 2052, x+240, 2124), radius=18, fill='#FFF2DA')
        text(x+120, 2088, value+' mm', 37, '#805014', 'mm')
        if i != 4:
            arrow((x+255, 2088), (x+294, 2088), '#A97832', 4)
    text(112, 2167, '先从最薄一档＋薄软泡棉试起，上下厚度一致。', 35)
    text(112, 2239, '仍前后晃 → 上下两条一起换厚一档。', 35)
    text(112, 2311, '后盖难合、有缝 → 减薄；不要用螺丝硬压合盖。', 35)
    draw.rounded_rectangle((106, 2380, 1694, 2450), radius=16, fill='#E5F3ED')
    text(130, 2398, '合适的状态：后盖自然合上，软垫轻压黑壳，轻晃不再碰撞。', 34, TEAL)

    text(85, 2510, '仅用软泡棉就能固定时，硬垫片可以不装。别把垫片贴到屏幕玻璃上。', 30, INK)
    text(85, 2564, '若是整个头在脖子上晃，或黑壳左右窜动，需要调整别的位置。', 30, MUTED)
    text(85, 2615, '后盖按 Marvin V4 模型网格绘制；黑壳、胶和泡棉为示意，厚度以实际试合为准。', 25, MUTED)
    args.out.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(args.out, dpi=(240, 240))
    print(args.out)


if __name__ == '__main__':
    main()
