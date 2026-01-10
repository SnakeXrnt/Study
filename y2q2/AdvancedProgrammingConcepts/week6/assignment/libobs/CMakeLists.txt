cmake_minimum_required(VERSION 3.28)

project(libObserver LANGUAGES CXX)

add_library(libObserver INTERFACE)

set_target_properties(libObserver PROPERTIES
        LANGUAGE CXX
        LINKER_LANGUAGE CXX
        CXX_STANDARD_REQUIRED ON
        CXX_EXTENSIONS OFF
        )

target_compile_features(libObserver INTERFACE cxx_std_20)

target_include_directories(libObserver
        INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
        )

add_subdirectory(tests)
