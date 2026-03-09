cmake_minimum_required(VERSION 3.30)
project(assignment_01)

set(target_up tests_unique)

add_executable(${target_up} test_unique.cpp)

target_link_libraries(${target_up} libptr)

target_include_directories(${target_up} PRIVATE include ../libptr/include/libptr )

target_compile_features(${target_up} PRIVATE cxx_std_23)

target_compile_options(${target_up} PRIVATE -Wall -Wextra -pedantic -Wshadow -Wconversion)

target_compile_options(${target_up} PRIVATE -fsanitize=undefined,address -fno-omit-frame-pointer -O0)
target_link_options(${target_up} PRIVATE -fsanitize=undefined,address)

target_compile_definitions(${target_up} PRIVATE 
    # Enable assertions
    ENABLE_ASSERTIONS=1
    # Enable debug output
    ENABLE_DEBUG=1
    # Enable grading output
    ENABLE_GRADING=1
)
