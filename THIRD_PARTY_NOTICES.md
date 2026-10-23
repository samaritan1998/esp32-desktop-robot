# 第三方来源与授权范围

## 小智 ESP32

- 上游：https://github.com/78/xiaozhi-esp32
- 基线：`v2.5.2`，提交 `49b4380b3faa0ceadd28a3e78aaf0f311c46c57e`。
- 许可：MIT，原版权与许可全文见 [LICENSES/xiaozhi-MIT.txt](LICENSES/xiaozhi-MIT.txt)。
- 本项目包含两个独立板型的适配、显示和互动代码，以及必要的 CMake／Kconfig 映射与音频状态诊断日志。板级初始化参考了上游微雪 1.83 寸板型；不宣称这些上游部分由本项目原创。
- 本仓库不镜像整个上游工程、Espressif SDK、托管组件、模型库或语音提示资源。准备脚本获取固定上游归档，组件由其原工具解析；它们仍适用各自许可证。`dependencies.lock` 是依赖版本记录，不是对所有依赖统一授予 MIT 许可。

## 字体

- 原字体：Noto Sans CJK SC Regular，Noto CJK 项目，Google／Adobe。
- 来源：https://github.com/notofonts/noto-cjk
- 固定提交：`f8d157532fbfaeda587e826d4cd5b21a49186f7c`。
- 文件：`Sans/OTF/SimplifiedChinese/NotoSansCJKsc-Regular.otf`。
- 许可：[SIL Open Font License 1.1](LICENSES/OFL-1.1-NotoSansCJK.txt)。
- 两个 `face_glyphs.h` 是重命名为 **Robot UI Bitmap** 的子集位图转换，保留 OFL，不适用 MIT。生成器与校验值见 `tools/generate_glyphs.py`、`firmware/font-source.json`。完整 OTF 不放入仓库。
- 发布源码不包含先前由系统字体生成的旧字模。预览图中的文字是排版后的图文，不是字体文件。

## 建模与预览依赖

建模工具使用 NumPy、Manifold、trimesh；字模和预览工具使用 Pillow。依赖通过包管理器安装，本仓库不捆绑这些库的源代码或二进制。

- NumPy：https://github.com/numpy/numpy （BSD-3-Clause）
- Manifold：https://github.com/elalish/manifold （Apache-2.0）
- trimesh：https://github.com/mikedh/trimesh （MIT）
- Pillow：https://github.com/python-pillow/Pillow （HPND 等，见上游许可）

## 硬件结构参考

Waveshare ESP32-S3-Touch-LCD-1.83：

- https://docs.waveshare.com/ESP32-S3-Touch-LCD-1.83
- https://docs.waveshare.com/ESP32-S3-Touch-LCD-1.83/Resources-And-Documents

模型为本项目脚本生成的布尔几何，未导入或随包分发厂商 STEP、DWG 或 PDF。名义黑壳尺寸只作为设计参考，不代替实测。

## 角色形象与商标

外观受 WALL-E 和 Marvin 启发。相关角色、原作品及商标的权利不因本项目的 MIT／CC 许可而转移或获得授权。本项目没有官方关联或授权，也不包含电影截图、原作音频或付费播客内容。
