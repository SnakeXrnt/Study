add_library(usb_descriptors STATIC
    usb_descriptors.c
)

target_include_directories(usb_descriptors PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(usb_descriptors
    pico_stdlib
    tinyusb_device
    tinyusb_board
)
