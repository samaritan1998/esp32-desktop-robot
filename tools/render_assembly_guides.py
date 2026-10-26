# SPDX-License-Identifier: MIT
"""Draw mechanical assembly posters from the released parametric model meshes.

The mesh generators are authoritative; black case, screen, foam and cable are
illustrations. Requires requirements-tools.txt and an OFL Noto Sans CJK font.
"""
from pathlib import Path
import argparse
import subprocess
import sys
import numpy as np
import trimesh
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1]
PAPER = '#F2F5F7'
INK = '#203341'
MUTED = '#536978'
TEAL = '#167F77'


def rgb(color):
    return np.array(tuple(bytes.fromhex(color.lstrip('#'))), dtype=float) / 255


def box(size, center, color):
    mesh = trimesh.creation.box(size)
    mesh.apply_translation(center)
    return (mesh.vertices, mesh.faces, color)


class View:
    """Orthographic per-pixel depth-buffer renderer with matching annotations."""
    def __init__(self, parts, size, az=-62, elev=23):
        self.parts = parts
        self.width, self.height = size
        az, elev = np.radians([az, elev])
        self.toward = np.array([np.cos(elev)*np.cos(az), np.cos(elev)*np.sin(az), np.sin(elev)])
        self.right = np.cross([0, 0, 1], self.toward)
        self.right /= np.linalg.norm(self.right)
        self.up = np.cross(self.toward, self.right)
        vertices = np.vstack([v for v, _, _ in parts])
        xy = np.column_stack((vertices @ self.right, vertices @ self.up))
        lo, hi = xy.min(axis=0), xy.max(axis=0)
        self.center = (lo+hi)/2
        self.scale = min((self.width-110)/(hi[0]-lo[0]), (self.height-110)/(hi[1]-lo[1]))

    def project(self, point):
        p = np.asarray(point)
        return np.array([(p @ self.right-self.center[0])*self.scale+self.width/2,
                         self.height/2-(p @ self.up-self.center[1])*self.scale])

    def render(self):
        canvas = np.zeros((self.height, self.width, 4), dtype=np.uint8)
        depth = np.full((self.height, self.width), -np.inf, dtype=np.float32)
        light = self.toward + np.array([-0.4, -0.2, 1.4])
        light /= np.linalg.norm(light)
        for v, faces, color in self.parts:
            color = rgb(color)
            projected = np.column_stack(((v @ self.right-self.center[0])*self.scale+self.width/2,
                                         self.height/2-(v @ self.up-self.center[1])*self.scale,
                                         v @ self.toward))
            for indices in faces:
                tri = v[indices]
                normal = np.cross(tri[1]-tri[0], tri[2]-tri[0])
                norm = np.linalg.norm(normal)
                if norm < 1e-9:
                    continue
                normal /= norm
                if normal @ self.toward <= 0:
                    continue
                p = projected[indices]
                x0, x1 = max(0, int(np.floor(p[:, 0].min()))), min(self.width-1, int(np.ceil(p[:, 0].max())))
                y0, y1 = max(0, int(np.floor(p[:, 1].min()))), min(self.height-1, int(np.ceil(p[:, 1].max())))
                if x0 > x1 or y0 > y1:
                    continue
                xx, yy = np.meshgrid(np.arange(x0, x1+1)+.5, np.arange(y0, y1+1)+.5)
                denominator = (p[1, 1]-p[2, 1])*(p[0, 0]-p[2, 0])+(p[2, 0]-p[1, 0])*(p[0, 1]-p[2, 1])
                if abs(denominator) < 1e-9:
                    continue
                a = ((p[1, 1]-p[2, 1])*(xx-p[2, 0])+(p[2, 0]-p[1, 0])*(yy-p[2, 1]))/denominator
                b = ((p[2, 1]-p[0, 1])*(xx-p[2, 0])+(p[0, 0]-p[2, 0])*(yy-p[2, 1]))/denominator
                c = 1-a-b
                z = a*p[0, 2]+b*p[1, 2]+c*p[2, 2]
                localdepth = depth[y0:y1+1, x0:x1+1]
                mask = (a >= -1e-7) & (b >= -1e-7) & (c >= -1e-7) & (z > localdepth)
                shade = .60+.40*max(0, normal @ light)
                pixel = np.clip(color*shade*255, 0, 255).astype(np.uint8)
                localdepth[mask] = z[mask]
                local = canvas[y0:y1+1, x0:x1+1]
                local[mask, :3] = pixel
                local[mask, 3] = 255
        return Image.fromarray(canvas)


class Poster:
    def __init__(self, font):
        self.image = Image.new('RGB', (2000, 3000), PAPER)
        self.draw = ImageDraw.Draw(self.image)
        self.font = font

    def text(self, pos, text, size=32, color=INK):
        font = ImageFont.truetype(str(self.font), size)
        self.draw.text(pos, text, font=font, fill=color, anchor='lt')

    def badge(self, pos, label, radius=29, color=TEAL):
        x, y = pos
        self.draw.ellipse((x-radius, y-radius, x+radius, y+radius), fill=color, outline='white', width=4)
        font = ImageFont.truetype(str(self.font), 26)
        self.draw.text((x, y-1), label, font=font, fill='white', anchor='mm')

    def arrow(self, start, end, color=TEAL, width=7):
        a, b = np.array(start), np.array(end)
        direction = b-a
        length = np.linalg.norm(direction)
        if length < 1:
            return
        u = direction/length
        n = np.array([-u[1], u[0]])
        self.draw.line([tuple(a), tuple(b-u*5)], fill=color, width=width)
        self.draw.polygon([tuple(b), tuple(b-u*25+n*12), tuple(b-u*25-n*12)], fill=color)

    def card(self, rect, title):
        self.draw.rounded_rectangle(rect, radius=30, fill='white')
        self.text((rect[0]+35, rect[1]+30), title, 43)

def draw_guide(robot, mesh_path, font, output):
    is_marvin = robot == 'marvin-v4'
    data = np.load(mesh_path)
    parts = {}
    names = [key[:-9] for key in data.files if key.endswith('_vertices') and not key.startswith('case')]
    for name in names:
        color = '#D4DEE3' if is_marvin else '#D9A743' if 'body' in name or 'arm' in name else '#495963' if 'track' in name or 'neck' in name else '#BBCAD4'
        parts[name] = (data[name+'_vertices'], data[name+'_faces'], color)
    case = (data['case_vertices'], data['case_faces'], '#263B46')
    front = '01_head_front' if is_marvin else '08_head_shell'
    cap = '02_head_back' if is_marvin else '09_head_back'
    body = '03_body_shell' if is_marvin else '01_body_shell'
    back = '04_body_back' if is_marvin else '02_body_back'
    neck = '09_neck' if is_marvin else '07_neck'
    hz = 70 if is_marvin else 76.5
    case_front = -13.4 if is_marvin else -11.4
    poster = Poster(font)

    def paste_view(items, rect, **kwargs):
        x, y, width, height = rect
        view = View(items, (width, height), **kwargs)
        layer = view.render()
        poster.image.paste(layer, (x, y), layer)
        return lambda p: view.project(p)+[x, y]

    def translated(name, offset):
        v, f, color = parts[name]
        return (v+offset, f, color)

    poster.text((80, 57), 'MARVIN V4 · 装配图' if is_marvin else 'WALL-E 风格 · 装配图', 69)
    poster.text((84, 153), '微雪 1.83 寸屏｜原装黑壳保留｜编号对应 STL 文件', 34, MUTED)
    poster.draw.rounded_rectangle((1540, 80, 1920, 142), radius=22, fill='#DDECE8')
    poster.text((1573, 95), 'v0.1.0 打印套装', 30, TEAL)

    poster.card((70, 230, 1930, 1420), '01 先干装身体、四肢和脖子')
    poster.text((110, 334), '身体后盖先留开，等 USB 走线完成后再关。', 31, MUTED)
    offsets = {}
    head_lift = 43 if is_marvin else 34
    for name in names:
        delta = np.zeros(3)
        if name == front:
            delta = np.array([0, 0, head_lift])
        elif name == cap:
            delta = np.array([0, 66, head_lift])
        elif name == back:
            delta = np.array([0, 27, 0])
        elif name == neck:
            delta = np.array([0, 0, 9])
        elif 'left' in name:
            delta = np.array([-18, 0, 0])
        elif 'right' in name:
            delta = np.array([18, 0, 0])
        offsets[name] = delta
    all_items = [translated(name, offsets[name]) for name in names]
    screen_offset = np.array([0, 32, head_lift])
    all_items.append((case[0]+screen_offset, case[1], case[2]))
    project = paste_view(all_items, (95, 402, 1260, 970), az=-63, elev=22)
    for name in names:
        v = parts[name][0]
        anchor = (v.min(axis=0)+v.max(axis=0))/2+offsets[name]
        poster.badge(project(anchor), name[:2])
    poster.badge(project(np.array([0, (case[0][:, 1].min()+case[0][:, 1].max())/2, hz])+screen_offset), '屏', color='#BD671E')
    poster.text((1400, 420), '对照零件编号', 35, TEAL)
    labels = ['头部前壳', '头部后盖', '身体', '身体后盖', '左手', '右手', '左脚', '右脚', '脖子'] if is_marvin else ['身体', '身体后盖', '左履带', '右履带', '左手', '右手', '脖子', '头部前壳', '头部后盖']
    for i, label in enumerate(labels):
        y = 497+i*66
        poster.badge((1430, y+17), f'{i+1:02}', 25)
        poster.text((1476, y), label, 32)
    poster.badge((1430, 1117), '屏', 25, '#BD671E')
    poster.text((1476, 1098), '已有的黑壳屏幕', 31)
    poster.text((1476, 1141), '不用打印／不用拆壳', 26, MUTED)
    poster.text((1397, 1235), 'Marvin：09 / 09b 二选一' if is_marvin else '10 号试片不装进整机', 28, MUTED)
    poster.text((1397, 1284), '先试插，确认后再少量粘接。', 26, MUTED)

    poster.card((70, 1460, 980, 2180), '02 黑壳从头部后方放入')
    poster.text((107, 1550), '屏幕正面朝前窗，不压玻璃。', 31, MUTED)
    shift = np.array([0, 33, 0])
    insert = [parts[front], (case[0]+shift, case[1], case[2])]
    project = paste_view(insert, (110, 1606, 830, 390), az=61, elev=28)
    poster.arrow(project([0, 35, hz-25]), project([0, 10, hz-25]))
    poster.badge(project((parts[front][0].min(0)+parts[front][0].max(0))/2), front[:2], 25)
    poster.badge(project([0, 33, hz]), '屏', 25, '#BD671E')
    poster.text((108, 2016), 'USB / PWR / BOOT 这一边朝下 ↓', 31, TEAL)
    poster.text((108, 2073), '先不插线；检查画面和触摸边缘。', 29, MUTED)

    poster.card((1020, 1460, 1930, 2180), '03 贴软垫，再合上头盖')
    poster.text((1057, 1550), '这里看的是后盖内侧。', 31, MUTED)
    padded = [parts[cap]]
    if is_marvin:
        for dz in (-9, 9):
            padded.append(box((24, 1.4, 4), (0, 7.7, hz+dz), '#E9B557'))
            padded.append(box((24, .6, 4), (0, 6.7, hz+dz), '#32BBA6'))
    else:
        for x in (-12, 12):
            for dz in (-9, 9):
                padded.append(box((4, 1, 4), (x, 7.9, hz+dz), '#32BBA6'))
    project = paste_view(padded, (1060, 1603, 830, 387), az=-75, elev=20)
    poster.badge(project([0, 22 if is_marvin else 14.2, hz+20]), cap[:2], 25)
    if is_marvin:
        poster.text((1058, 2005), '需垫片时：上下同档各一条＋薄软垫', 29, TEAL)
        poster.text((1058, 2050), '按间隙选五档中的一档；声孔留空。', 29, MUTED)
    else:
        poster.text((1058, 2005), '四个接触柱，各贴一块软泡棉。', 30, TEAL)
        poster.text((1058, 2050), '约 4×4 mm、1 mm 厚起配，紧则减薄。', 28, MUTED)
    poster.text((1058, 2100), '橙色＝可选硬垫片，绿色＝软垫。' if is_marvin else '绿色＝软垫；中间声孔留空。', 29, MUTED)

    poster.card((70, 2220, 1930, 2820), '04 先插 USB，再把头部落到脖子上')
    lift = np.array([0, 0, 14])
    final = [translated(name, lift if name in (front, cap) else np.zeros(3)) for name in names]
    final.append((case[0]+lift, case[1], case[2]))
    port_z = hz-18.6
    final.append(box((12, 9, 15), (0, -4.5, port_z-7.5+14), '#2D7C76'))
    project = paste_view(final, (100, 2330, 670, 450), az=-63, elev=18)
    poster.arrow(project([23, 9, (39 if is_marvin else 51)+12]), project([23, 9, (39 if is_marvin else 51)+2]))
    # Cable route is deliberately a line diagram, not a manufactured connector.
    cable = [project([0, -4.5, port_z-15+14]), project([0, -4.5, port_z-25+14]),
             project([0, -13, 32 if is_marvin else 40]), project([18, -17, 23 if is_marvin else 30])]
    poster.draw.line([tuple(p) for p in cable], fill=TEAL, width=10, joint='curve')
    poster.text((845, 2362), '1. 头盖固定好，先插 USB，再放上脖子。', 35)
    poster.text((845, 2430), '2. 线走身体前侧避让口，留出松弛。', 35)
    poster.text((845, 2498), '3. 最后关身体后盖，试触摸、说话和播放。', 33)
    poster.text((845, 2585), '头盖：M2×10 自攻螺丝 4 颗' if is_marvin else '头盖：M2×8 自攻螺丝 4 颗', 34, TEAL)
    poster.text((845, 2640), '身体：M2×8 自攻螺丝 4 颗', 34, TEAL)
    poster.text((845, 2710), '后盖要自然贴合，不用螺丝硬拉合。', 31, MUTED)

    poster.text((80, 2868), '按实际模型网格绘制；黑壳、插头和线为示意，接口位置以实物为准。', 29, MUTED)
    poster.text((80, 2920), 'Marvin V4 尚未实物确认；装配时不要硬压玻璃或强拧后盖。' if is_marvin else '10 号试片不用装；履带为固定件。螺丝长度和软垫厚度按实际配合确认。', 28, MUTED)
    poster.image.save(output, dpi=(240, 240))
    print(output, flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--font', type=Path, default=ROOT/'.cache/NotoSansCJKsc-Regular.otf')
    parser.add_argument('--out', type=Path, default=ROOT/'docs/images')
    args = parser.parse_args()
    if not args.font.exists():
        parser.error('Supply --font with NotoSansCJKsc-Regular.otf; tools/generate_glyphs.py can download it.')
    args.out.mkdir(parents=True, exist_ok=True)
    for robot in ('marvin-v4', 'walle'):
        source = ROOT/'models'/robot
        if robot == 'marvin-v4':
            source /= 'source'
        generated = ROOT/'.build/assembly-guides'/robot
        mesh_path = generated/'assembly_mesh_data.npz'
        subprocess.run([sys.executable, str(source/'build_model.py'), '--parameters',
                        str(source/'parameters.json'), '--out', str(generated)], check=True)
        draw_guide(robot, mesh_path, args.font, args.out/(robot+'-assembly-guide.png'))


if __name__ == '__main__':
    main()
