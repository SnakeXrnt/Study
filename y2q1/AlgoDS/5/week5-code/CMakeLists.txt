cmake_minimum_required(VERSION 3.10.0)
project(week2 VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)

add_subdirectory(heapify)
add_subdirectory(heap_remove)
add_subdirectory(median)
add_subdirectory(coordinates)
add_subdirectory(linear_probing)
add_subdirectory(separate_chaining)
