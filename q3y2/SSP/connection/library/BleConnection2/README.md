# BleConnection2 Library

A unified BLE communication bridge between **Arduino Nano 33 BLE (Server)** and **ESP32 (Client)**, optimized for high-speed data transmission (e.g., IMU data).

## 1. Project Structure

- `libs/`: Contains the core library files (`BleConnection.h`, `BleConnection.cpp`).
- `example/`: Contains example code for both Server (Nano 33 BLE) and Client (ESP32).
- `CMakeLists.txt`: Build configuration for CMake-based projects.

---

## 2. How to Integrate into Your Project

### Option A: Manual Copy (Easiest for Arduino IDE)
1. Copy the `libs/BleConnection.h` and `libs/BleConnection.cpp` files into your project's `src` or main folder.
2. In your code, include it: `#include "BleConnection.h"`.

### Option B: PlatformIO (Recommended)
1. Copy the entire `BleConnection2` folder into your project's `lib/` directory.
2. Add the following dependencies to your `platformio.ini`:
   ```ini
   # For ESP32 Client
   [env:esp32]
   lib_deps = h2zero/NimBLE-Arduino@^1.4.1
   
   # For Nano 33 BLE Server
   [env:nano33ble]
   lib_deps = arduino-libraries/ArduinoBLE@^1.3.6
   ```

### Option C: Using CMake
If your project uses CMake, you can add this library as a subdirectory:
1. Put `BleConnection2` in your project folder (e.g., in `external/BleConnection2`).
2. Add these lines to your main `CMakeLists.txt`:
   ```cmake
   add_subdirectory(external/BleConnection2)
   target_link_libraries(your_project_name PRIVATE BleConnection)
   ```

---

## 3. Usage Guide

### Shared Data Structure
The library uses the `ImuSample` struct for data transfer. You can modify this in `BleConnection.h` if you need different data fields.

```cpp
struct ImuSample {
    int16_t ax, ay, az;
    int16_t gx, gy, gz;
};
```

### Server Side (Arduino Nano 33 BLE)
```cpp
#include <BleConnection.h>
BleConnection ble;

void setup() {
    ble.initServer("MyDeviceName");
}

void loop() {
    ble.updateServer(); // Must be called frequently
    if (ble.isConnected()) {
        ImuSample data[BLE_NUM_IMUS];
        // ... fill data ...
        ble.sendData(data, BLE_NUM_IMUS);
    }
}
```

### Client Side (ESP32)
```cpp
#include <BleConnection.h>
BleConnection ble;

void onData(uint8_t seq, uint32_t ts, ImuSample* samples) {
    // Handle received data here
}

void setup() {
    ble.initClient(onData);
}

void loop() {
    ble.updateClient(); // Must be called frequently
}
```

---

## 4. Dependencies
This library relies on platform-specific BLE stacks:
- **Arduino Nano 33 BLE**: [ArduinoBLE](https://github.com/arduino-libraries/ArduinoBLE)
- **ESP32**: [NimBLE-Arduino](https://github.com/h2zero/NimBLE-Arduino)
