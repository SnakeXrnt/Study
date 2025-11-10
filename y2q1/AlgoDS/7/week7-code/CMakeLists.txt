cmake_minimum_required(VERSION 3.10.0)
project(week2 VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)

add_subdirectory(1.topsort)
add_subdirectory(2.firedepartment)
add_subdirectory(3.cycles)
add_subdirectory(4.satellites)
add_subdirectory(5.spanningtree)
add_subdirectory(6.shortestpaths)
