cmake_minimum_required(VERSION 4.1.0)

project(libptr)

add_library(${PROJECT_NAME} INTERFACE EXCLUDE_FROM_ALL)

target_sources(${PROJECT_NAME} PUBLIC
  FILE_SET HEADERS
    BASE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include/
    FILES include/libptr/unique_ptr.hpp )

target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_23)

target_compile_options(${PROJECT_NAME} INTERFACE -Wall -Wextra -pedantic -Wshadow)



