cmake_minimum_required(VERSION 3.28)

project(advanced_programming_concepts_3)

add_executable(assignment_3)

target_sources(assignment_3 PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src/program.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/logger.cpp 
    ${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/time/system_time_source.cpp
)

target_include_directories(assignment_3 PRIVATE include)

target_compile_features(assignment_3 PRIVATE cxx_std_23)
target_compile_options(assignment_3 PRIVATE -Wall -Wextra -Wpedantic -Werror)

include(CheckCXXCompilerFlag)
include(CMakePushCheckState)

cmake_push_check_state()

set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=address" "-fsanitize=undefined")

check_cxx_compiler_flag("-fsanitize=address" HAS_ASAN)
check_cxx_compiler_flag("-fsanitize=undefined" HAS_UBSAN)
cmake_pop_check_state()

if(HAS_ASAN)
    target_compile_options(assignment_3 PRIVATE -fsanitize=address -fno-omit-frame-pointer -Og)
    target_link_options(assignment_3 PRIVATE -fsanitize=address)
endif()

if(HAS_UBSAN)
    target_compile_options(assignment_3 PRIVATE -fsanitize=undefined)
    target_link_options(assignment_3 PRIVATE -fsanitize=undefined)
endif()
