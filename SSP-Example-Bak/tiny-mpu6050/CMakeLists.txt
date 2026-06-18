# This repeats part of the root CMakeLists.txt if one plans to build this
# example separately from the root CMakeLists.txt. See README.md for details.

option(BUILD_tiny_mpu6050_example
       "Build the tiny-mpu6050 with Complementary sensor fusion example" OFF)

if(NOT BUILD_tiny_mpu6050_example)
  message(STATUS "Skipping build of tiny_mpu6050_example")
  return()
endif()

cmake_minimum_required(VERSION 3.13)

# Set default C and C++ standards.
set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 20)

# Require the compiler to support the specified standard and not silently
# decaying into an older standard.
set_property(GLOBAL PROPERTY C_STANDARD_REQUIRED YES)
set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED YES)

# Include cmake directory with utility files to assist development.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../cmake")

include(ClangTidy) # Include clang-tidy runner utility.
include(PicoSetup) # Include Pico SDK setup utility.

project(
  tiny_mpu6050_example
  VERSION 0.0.1
  LANGUAGES C CXX ASM)

pico_sdk_init()

# Generate configuration for clang-tidy. See cmake/ClangTidy.cmake for details.
# To run it automatically during each build, execute:
#
# cmake -B build -DCLANG_TIDY_AUTORUN=on <your other CMake options>
#
# Or:
#
# cd build && cmake .. -DCLANG_TIDY_AUTORUN=on <your other CMake options>
#
# One can also run it manually with `cmake --build build --target clang-tidy`.
clang_tidy_enable()

set(TARGET_EXAMPLE tiny_mpu6050_example)

add_executable("${TARGET_EXAMPLE}" tiny_mpu6050.c)

target_compile_options("${TARGET_EXAMPLE}" PRIVATE -Wall -Werror)

target_link_libraries("${TARGET_EXAMPLE}" PRIVATE pico_stdlib hardware_i2c
                                                  tiny_mpu6050)

target_compile_definitions(
  "${TARGET_EXAMPLE}" PRIVATE # TINY_MPU6050_WHOAMI_VALUE=0x68 # For MPU6050.
                              TINY_MPU6050_WHOAMI_VALUE=0x70 # For MPU6500.
)

pico_enable_stdio_usb("${TARGET_EXAMPLE}" 1)
pico_enable_stdio_uart("${TARGET_EXAMPLE}" 0)

pico_add_extra_outputs("${TARGET_EXAMPLE}")
