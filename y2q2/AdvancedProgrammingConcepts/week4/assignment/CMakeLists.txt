cmake_minimum_required(VERSION 3.28)

project(advanced_programming_concepts_4)

add_executable(assignment_4
    src/main.cpp
    src/program.cpp
    src/logger.cpp
    src/multi_writer.cpp
    src/stream_writer.cpp
    src/console_writer.cpp
    src/file_writer_adapter.cpp
    src/decorators/timestamp_decorator.cpp
)

target_include_directories(assignment_4 PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(assignment_4 PROPERTIES
    LANGUAGE CXX
    LINKER_LANGUAGE CXX
    CXX_STANDARD 23
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

target_compile_features(assignment_4 PRIVATE cxx_std_23)
target_compile_options(assignment_4 PRIVATE -Wall -Wextra -pedantic)

add_subdirectory(clib)
target_link_libraries(assignment_4 PRIVATE clib)

include(CheckCXXCompilerFlag)
include(CMakePushCheckState)

cmake_push_check_state()

set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=address" "-fsanitize=undefined")

check_cxx_compiler_flag("-fsanitize=address" HAS_ASAN)
check_cxx_compiler_flag("-fsanitize=undefined" HAS_UBSAN)
cmake_pop_check_state()

if(HAS_ASAN)
    target_compile_options(assignment_4 PRIVATE -fsanitize=address -fno-omit-frame-pointer -Og -fsanitize-address-use-after-return=always)
    target_link_options(assignment_4 PRIVATE -fsanitize=address)
endif()

if(HAS_UBSAN)
    target_compile_options(assignment_4 PRIVATE -fsanitize=undefined)
    target_link_options(assignment_4 PRIVATE -fsanitize=undefined)
endif()