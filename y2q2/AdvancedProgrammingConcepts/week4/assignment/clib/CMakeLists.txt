cmake_minimum_required(VERSION 3.28)

project(CLib LANGUAGES C CXX)

add_library(clib STATIC logger.c file_writer.cpp)

set_target_properties(clib PROPERTIES
	C_STANDARD 23
	C_STANDARD_REQUIRED ON
	C_EXTENSIONS OFF
	CXX_STANDARD 11
	CXX_STANDARD_REQUIRED ON
	CXX_EXTENSIONS OFF
)

target_include_directories(clib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(clib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/clib)

target_compile_options(clib PRIVATE -Wall -Wextra -Wpedantic)
target_compile_features(clib PRIVATE cxx_std_11)

