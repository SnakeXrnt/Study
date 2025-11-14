cmake_minimum_required(VERSION 3.30)
project(assignment_01)

add_subdirectory(libptr)
add_subdirectory(tests)

add_executable(assignment_01 main.cpp)
target_link_libraries(assignment_01 PRIVATE libptr )

target_compile_definitions(assignment_01 PRIVATE cxx_std_23)

target_compile_options(assignment_01 PRIVATE -Wall -Wextra -pedantic)

option(ENABLE_SANITIZERS TRUE)

# Sanitizers, enabled by default

if(ENABLE_SANITIZERS)
    target_compile_options(assignment_01 PRIVATE -fsanitize=undefined,address -fno-omit-frame-pointer -O0)
    target_link_options(assignment_01 PRIVATE -fsanitize=undefined,address)
endif(ENABLE_SANITIZERS)
