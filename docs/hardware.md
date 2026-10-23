# 硬件范围

本项目适配 **Waveshare ESP32-S3-Touch-LCD-1.83**，不是仅凭“ESP32-S3”字样就兼容的通用固件。板上需有对应 LCD、触摸、音频编解码器、IMU 和 AXP2101 电源管理芯片。使用板上 ESP32-S3，16 MB Flash / 8 MB PSRAM。

外壳默认保留原装黑壳，名义横向尺寸约 44.2 × 37.2 × 19 mm。Marvin V4 使用 46 × 40 × 21 mm 的保守设计包络，再给宽高每侧 0.8 mm 余量；这是设计假设，不能写成已实测的产品尺寸。

| 音频引脚 | GPIO |
| --- | --- |
| I2S MCLK | 16 |
| I2S WS | 45 |
| I2S BCLK | 9 |
| I2S DIN | 10 |
| I2S DOUT | 8 |

完整 LCD、触摸和 I2C 引脚以各板型 `config.h` 及微雪官方原理图为准。不要在其他板子上试刷来猜测接线。两款角色使用同一块硬件，模型和固件角色可以分别选择。

官方资料：[产品文档](https://docs.waveshare.com/ESP32-S3-Touch-LCD-1.83)、[结构及原理图](https://docs.waveshare.com/ESP32-S3-Touch-LCD-1.83/Resources-And-Documents)。

外壳没有额外电机、电池或功放设计。安装后检查线缆、PWR／BOOT 操作、触摸区域、麦克风和扬声器声孔，不要用泡棉堵住原装声孔。
