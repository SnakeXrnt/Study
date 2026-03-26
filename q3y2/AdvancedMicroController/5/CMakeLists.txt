cmake_minimum_required(VERSION 4.2)
include(pico_sdk_import.cmake)
include(pico_extras_import.cmake)

project(Week1 C CXX ASM)
pico_sdk_init()

add_library(common_lib STATIC)
target_link_libraries(common_lib PUBLIC
    pico_stdlib
    hardware_pio
    hardware_i2c
    hardware_pwm
    hardware_sleep
)

add_executable(picohost picohost.c)
target_link_libraries(picohost PRIVATE common_lib)
pico_enable_stdio_usb(picohost 1)
pico_enable_stdio_uart(picohost 0)
pico_add_extra_outputs(picohost)

add_executable(picoslave picoslave.c)
target_link_libraries(picoslave PRIVATE common_lib)
pico_enable_stdio_usb(picoslave 1)
pico_enable_stdio_uart(picoslave 0)
pico_add_extra_outputs(picoslave)
