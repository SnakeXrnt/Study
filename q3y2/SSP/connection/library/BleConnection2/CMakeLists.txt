cmake_minimum_required(VERSION 3.10)
project(BleConnection2)

# This library is designed for Arduino-based platforms (ESP32 and Nano 33 BLE).
# When using with CMake (e.g., in ESP-IDF or with Arduino-CMake-Toolchain), 
# you can include this directory.

set(CMAKE_CXX_STANDARD 11)

# Define the library source files
set(SOURCES
    libs/BleConnection.cpp
)

# Define the library
add_library(BleConnection STATIC ${SOURCES})

# Export the include directory so users can #include <BleConnection.h>
target_include_directories(BleConnection PUBLIC libs)

# Note on Dependencies:
# - For ESP32: Requires NimBLE-Arduino library.
# - For Nano 33 BLE: Requires ArduinoBLE library.
# These are typically managed via PlatformIO (platformio.ini) or Arduino Library Manager.
