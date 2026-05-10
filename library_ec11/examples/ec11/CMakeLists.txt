cmake_minimum_required(VERSION 4.3)

# Pull in SDK (must be before project)
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

project(ec11-example C CXX ASM)

# Initialize the SDK
pico_sdk_init()

set(EXAMPLE ec11-example)

# Add the library
add_subdirectory(../../ec11 ec11)

add_executable(${EXAMPLE} main.c)
target_compile_options(${EXAMPLE} PRIVATE -Wall)

target_link_libraries(${EXAMPLE} PRIVATE
    pico_stdlib
    hardware_pio
    ec11
)

add_compile_definitions(
    PICO_DEFAULT_EC11_PIN_BTN=22
    PICO_DEFAULT_EC11_PIN_A=26
    PICO_DEFAULT_EC11_PIN_B=18
)

pico_enable_stdio_usb(${EXAMPLE} 1)
pico_enable_stdio_uart(${EXAMPLE} 0)

pico_add_extra_outputs(${EXAMPLE})
