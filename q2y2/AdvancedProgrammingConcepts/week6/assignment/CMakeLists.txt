cmake_minimum_required(VERSION 3.28)

project(advanced_programming_concepts_6)

add_executable(assignment_week_6
    src/main.cpp
    src/program.cpp
    src/logger.cpp
    src/multi_writer.cpp
    src/stream_writer.cpp
    src/console_writer.cpp
    src/clogger_as_writer.cpp
    src/file_writer_adapter.cpp
    src/clogger_adapter.cpp
    src/severity_proxy.cpp
    src/decorators/timestamp_decorator.cpp
    src/decorators/runningtime_decorator.cpp
    src/decorators/observable_decorator.cpp
    src/builder/logger_builder.cpp
    src/global/runningtime_provider.cpp
)

target_include_directories(assignment_week_6 PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(assignment_week_6 PROPERTIES
    LANGUAGE CXX
    LINKER_LANGUAGE CXX
    CXX_STANDARD 23
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
)

target_compile_features(assignment_week_6 PRIVATE cxx_std_23)
target_compile_options(assignment_week_6 PRIVATE -Wall -Wextra -pedantic)

add_subdirectory(clib)
add_subdirectory(libobs)
target_link_libraries(assignment_week_6 PRIVATE clib libObserver)

include(CheckCXXCompilerFlag)
include(CMakePushCheckState)

cmake_push_check_state()

set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=address" "-fsanitize=undefined")

check_cxx_compiler_flag("-fsanitize=address" HAS_ASAN)
check_cxx_compiler_flag("-fsanitize=undefined" HAS_UBSAN)
cmake_pop_check_state()

if(HAS_ASAN)
    target_compile_options(assignment_week_6 PRIVATE -fsanitize=address -fno-omit-frame-pointer -Og)
    target_link_options(assignment_week_6 PRIVATE -fsanitize=address)
endif()

if(HAS_UBSAN)
    target_compile_options(assignment_week_6 PRIVATE -fsanitize=undefined)
    target_link_options(assignment_week_6 PRIVATE -fsanitize=undefined)
endif()