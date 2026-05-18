add_library(numpad STATIC
    numpad.c
)

target_include_directories(numpad PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(numpad
    pico_stdlib
    tinyusb_device
)
