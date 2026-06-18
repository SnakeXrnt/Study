cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)

set(PICO_BOARD pico_w)

project(Macropad C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_subdirectory(lib/ec11)
add_subdirectory(lib/numpad)
add_subdirectory(lib/oled)
add_subdirectory(lib/usb_descriptors)

add_executable(Macropad
    src/main.c
)

# Add include directory for tusb_config.h
target_include_directories(Macropad PRIVATE src/)

# Link libraries
target_link_libraries(Macropad
    pico_stdlib
    tinyusb_device
    tinyusb_board
    ec11
    numpad
    oled
    usb_descriptors
)

# Disable USB and UART stdio since we're using custom USB HID
pico_enable_stdio_usb(Macropad 0)
pico_enable_stdio_uart(Macropad 0)

# Create the .uf2, .elf, .bin, .hex files
pico_add_extra_outputs(Macropad)
