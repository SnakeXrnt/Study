cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)

set(PICO_BOARD pico_w)

project(Macropad C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

pico_sdk_init()

add_executable(Macropad
    main.c
    usb_descriptors.c
)

add_subdirectory(lib/ec11)

# Add include directory for tusb_config.h
target_include_directories(Macropad PRIVATE ${CMAKE_CURRENT_LIST_DIR})

# Pull in the TinyUSB device library
target_link_libraries(Macropad
    pico_stdlib
    tinyusb_device
    tinyusb_board
    ec11
)

# Disable USB and UART stdio since we're using custom USB HID
pico_enable_stdio_usb(Macropad 0)
pico_enable_stdio_uart(Macropad 0)

# Create the .uf2, .elf, .bin, .hex files
pico_add_extra_outputs(Macropad)
