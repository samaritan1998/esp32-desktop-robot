# Marvin 1.83 voice robot

Waveshare ESP32-S3-Touch-LCD-1.83,16MB Flash/8MB Octal PSRAM. Same physical pins,
audio codecs, landscape touch mapping and 40ms I2C deadlines as physically tested
WALL-E v3.0.2. Unique marvin-183 board identity. Heavy pale green lids, small frown,
listening/thinking/speaking animations; touch, shake and a six-card fortune game.

Build: python scripts/build.py marvin-183 --name marvin-183 --language zh-CN --wake-word disabled --zip

Tap bottom or BOOT to chat. No wake word. Hold2sec for fortune, doubletap returns.
Cloud persona must be set in the account control panel; firmware cannot replace
the bound agent's name or voice. Hardware and fit validation are reported separately.
