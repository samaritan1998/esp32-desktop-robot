# WALL-E 1.83 voice robot

Waveshare ESP32-S3-Touch-LCD-1.83, 16MB quad Flash / 8MB Octal PSRAM. Stock audio pins and codecs; landscape display matches working v2. Mic ALDO1 enabled without modifying battery charge parameters. Custom board identity protects the customized UI from stock OTA firmware.

Build: `python scripts/build.py walle-183 --name walle-183 --language zh-CN --wake-word disabled --zip`.

Tap bottom voice control or BOOT to start/stop conversation. Other face gestures retain v2 play; hold two seconds for fortune game, double tap to return. Configure Wi-Fi using the generated Xiaozhi hotspot, then bind the announced code at xiaozhi.me. Never bundle original flash backups or Wi-Fi credentials.
