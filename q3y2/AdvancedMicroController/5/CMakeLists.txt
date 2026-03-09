
cmake_minimum_required(VERSION 4.2)

include(pico_sdk_import.cmake)

project(Week1 C CXX ASM)

add_executable(hello_pio)

pico_sdk_init()

pico_generate_pio_header(hello_pio ${CMAKE_CURRENT_LIST_DIR}/hello.pio)

target_sources(hello_pio PRIVATE hello.c)

target_link_libraries(hello_pio PRIVATE
        pico_stdlib
        hardware_pio
        hardware_i2c
        pico_cyw43_arch_none 
        )


pico_add_extra_outputs(hello_pio)

# add url via pico_set_program_url
# example_auto_set_url(hello_pio)
