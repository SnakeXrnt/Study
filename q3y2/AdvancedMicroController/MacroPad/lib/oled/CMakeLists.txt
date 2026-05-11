add_library(oled STATIC
    ssd1306.c
    font.c
)

target_include_directories(oled PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(oled
    pico_stdlib
    hardware_i2c
)
