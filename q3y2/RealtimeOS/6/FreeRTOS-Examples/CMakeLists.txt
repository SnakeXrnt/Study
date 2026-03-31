cmake_minimum_required(VERSION 3.13)

# TODO: Set your project name here:
set(PROJECT rtos-project)

if (NOT DEFINED ENV{PICO_SDK_PATH})
    message("PICO_SDK_PATH not set, looking for alternative paths")
    if (EXISTS $ENV{HOME}/Pico/pico-sdk)
        set(PICO_SDK_PATH $ENV{HOME}/Pico/pico-sdk)
    elseif(EXISTS $ENV{HOME}/pico/pico-sdk)
        set(PICO_SDK_PATH $ENV{HOME}/pico/pico-sdk)
    elseif (EXISTS $ENV{HOME}/pico-sdk)
        set(PICO_SDK_PATH $ENV{HOME}/pico-sdk)
    else()
        message(FATAL_ERROR "PICO_SDK_PATH not set and SDK not found in default locations")
    endif()
    message("PICO_SDK_PATH set to ${PICO_SDK_PATH}")
else()
    set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
    message("PICO_SDK_PATH found in ENV and set to ${PICO_SDK_PATH}")
endif()

set(PICO_BOARD "pico_w")
set(ENABLE_WIFI off)

set(PICO_SDK_FETCH_FROM_GIT off)
include(pico_sdk_import.cmake)

project(${PROJECT})

pico_sdk_init()

# If the path to FreeRTOS is not provided, check it out from Git
if(NOT ENV{FREERTOS_KERNEL_PATH} AND NOT FREERTOS_KERNEL_PATH)
    set(FREERTOS_KERNEL_PATH ${CMAKE_CURRENT_SOURCE_DIR}/FreeRTOS-Kernel)
    include(FetchContent)
    FetchContent_Declare(freertos_kernel
        GIT_REPOSITORY https://github.com/FreeRTOS/FreeRTOS-Kernel.git
        GIT_TAG V11.2.0     # Use 'main' to check out the most current version
        SOURCE_DIR ${FREERTOS_KERNEL_PATH}
    )
    FetchContent_Populate(freertos_kernel)
endif()

include(FreeRTOS_Kernel_import.cmake)

add_library(freertos_config INTERFACE)
target_include_directories(freertos_config SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})

add_compile_options(-Wall -Wno-format -Wno-unused-function -Wno-maybe-uninitialized)

file(GLOB SOURCES "*.h" "*.c")
add_executable(${PROJECT} ${SOURCES})

target_link_libraries(${PROJECT} PRIVATE
    pico_stdlib
    pico_rand
    hardware_gpio
    pico_multicore

    freertos_config
    FreeRTOS-Kernel
    FreeRTOS-Kernel-Heap3
)

pico_add_extra_outputs(${PROJECT})

pico_enable_stdio_usb(${PROJECT} 1)
pico_enable_stdio_uart(${PROJECT} 0)

if (${ENABLE_WIFI} AND PICO_CYW43_SUPPORTED)
    add_compile_definitions(WIFI)
    target_link_libraries(${PROJECT_NAME} pico_cyw43_arch_none)
endif ()