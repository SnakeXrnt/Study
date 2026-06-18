# Connection: BLE IMU Streaming Project

A real-time sensor data streaming system using BLE between an ESP32-C3 server and a Lilygo T-Display client.

## Architecture

- **Server (ESP32-C3):** Simulates/Reads data from 6 IMUs and streams it via BLE Notifications.
- **Client (Lilygo T-Display):** Connects to the server, receives data, and displays it on a color TFT.

## Hardware Details

### Server
- **Board:** ESP32-C3-DevKitM-1
- **Display:** SSD1306 OLED (I2C: SDA=8, SCL=9)
- **Input:** Button on Pin 2 (toggles display pages)
- **Libraries:** `NimBLE-Arduino`, `Adafruit SSD1306`, `Adafruit GFX`

### Client
- **Board:** Lilygo T-Display (ESP32)
- **Display:** Built-in ST7789 TFT (135x240)
- **Libraries:** `NimBLE-Arduino`, `TFT_eSPI`

## Communication Protocol (BLE)

- **Service UUID:** `4fafc201-1fb5-459e-8fcc-c5c9c331914b`
- **Characteristic UUID:** `beb5483e-36e1-4688-b7f5-ea07361b26a8` (Notify)
- **MTU:** 200 bytes
- **Update Rate:** ~60Hz
- **Packet Structure (77 bytes):**
  - `[0]`: Sequence number (uint8_t)
  - `[1..4]`: Timestamp (uint32_t, ms)
  - `[5..76]`: 6x IMU Samples (12 bytes each)
    - `int16_t ax, ay, az, gx, gy, gz`

## Development Notes
- The client uses a custom `User_Setup.h` for `TFT_eSPI` configuration.
- Server simulates data currently in `loop()` but is structured for real sensor integration.
- Both projects use PlatformIO.
