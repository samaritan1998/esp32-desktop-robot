# 编译与使用固件

这里提供可编译的源码、两个板型适配和固定上游补丁。本次公开版**不附刷机二进制**，也不包含联网设置或设备备份。

## 版本与硬件

- 微雪 ESP32-S3-Touch-LCD-1.83，16 MB Flash / 8 MB PSRAM。
- 小智上游 `78/xiaozhi-esp32`，`v2.5.2`，固定提交及归档 SHA256 见 [upstream.json](upstream.json)。
- ESP-IDF `v6.1.0`。准备脚本使用 Python 3.12+；需要 git。
- 两个独立板型：`marvin-183`、`walle-183`。不覆盖上游官方微雪板型。

## 准备源码

在本仓库根目录执行：

```sh
python3 tools/prepare_firmware.py
```

脚本下载并校验固定归档，检查原始核心文件，应用 `core.patch`，复制板型与依赖锁文件，生成 `.build/xiaozhi-esp32/`。目标目录若已存在会停止，避免覆盖修改；可用 `--out` 指定新的空路径。离线时可用 `--archive` 指定校验一致的上游归档。

不要直接把这份补丁应用到上游最新主分支；接口和构建配置可能已经变化。

## 编译

按 [Espressif 官方文档](https://docs.espressif.com/projects/esp-idf/en/v6.1/esp32s3/get-started/) 安装 ESP-IDF v6.1 和 ESP32-S3 工具链，然后执行：

```sh
source /path/to/esp-idf/export.sh
cd .build/xiaozhi-esp32
python scripts/build.py marvin-183 --name marvin-183 --language zh-CN --wake-word disabled --zip
```

编译 WALL-E 时，将命令中的两处 `marvin-183` 改为 `walle-183`。同一构建目录每次只对应一个板型；不要以为重新编译后还保留上一个角色的产物。输出位置以构建脚本提示为准，构建结束后的 `build/flasher_args.json` 记录对应分区的写入地址。

编译不等于在实机上验证。本次公开版将静态中文字模改为 OFL 字体，已验证的内容见 [验证记录](../docs/validation.md)。暂不提供已刷机验证的二进制 release。

## 写入自己的板子

确认端口对应这块微雪屏幕，再使用该构建目录的 `idf.py -p YOUR_PORT flash`；不要根据其他板型的地址手工拼刷机命令。首次刷写或改变分区会影响原有应用与设置。个人完整 Flash 备份可能含 Wi-Fi 和云端凭证，只能自己保存，不要上传到仓库或 Issue。

如果自动进入下载模式失败，按住 BOOT 后重新上电，稍等再松开 BOOT。涉及 AXP2101 电源管理的板子可能需要先长按 PWR 关机，再按住 BOOT、单击 PWR 开机。进入下载模式时屏幕黑着可以是正常现象。

## 联网与互动

1. 按屏幕／语音提示连接设备热点，在配网页选择 2.4 GHz Wi-Fi。
2. 如果使用兼容的小智在线服务，按服务说明登录自己的账号，用设备提示的绑定码添加设备。不要公开绑定码。
3. 点底部说话区或按 BOOT 开始对话。说完先等待播放，重复点击会结束聆听或打断回答。默认没有唤醒词。
4. 待机时轻点眼睛互动，轻晃进入转圈眼，长按约 2 秒抽签，双击返回。

角色名称、音色和 AI 人设由你使用的服务端控制；固件切换外观不等于自动更换云端角色。可参考 [Marvin 提示词](../docs/personas/marvin.txt) 和 [WALL-E 提示词](../docs/personas/walle.txt)，在自己的服务控制台手动配置。

## 字模再生成与桌面预览

仓库已经包含生成好的 `face_glyphs.h`，正常编译无需下载完整字体。

```sh
python3 -m pip install -r requirements-tools.txt
python3 tools/generate_glyphs.py
python3 tools/render_faces.py
```

字模工具校验固定 Noto 字体的 SHA256，将两套界面中的文字转换为 Robot UI Bitmap，保留 SIL OFL 1.1 许可。预览工具需要支持 C++17 的编译器，结果在 `.build/face-previews/`。渲染覆盖表情和抽签状态，检查画布边界；不模拟触摸硬件、声音或网络。

USB 原生串口还保留角色前缀命令（`marvin.status`／`walle.status` 等）。它们用于本地调试，串口日志可能含设备状态或对话信息，不要原样公开。
