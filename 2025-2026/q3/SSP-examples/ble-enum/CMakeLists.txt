cmake_minimum_required(VERSION 3.13)

# Define the library source files
set(BLE_ENUM_SOURCES
    libs/BleConnectionEnum.cpp
)

# Define the library
add_library(BleConnectionEnum STATIC ${BLE_ENUM_SOURCES})

# Export the include directory
target_include_directories(BleConnectionEnum PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/libs")

# Ensure it uses the project-wide C++ standard if not already set.
if(NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 20)
endif()
