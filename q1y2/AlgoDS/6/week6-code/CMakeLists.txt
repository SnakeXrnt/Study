cmake_minimum_required(VERSION 3.10.0)
project(week2 VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)

add_subdirectory(connectedness)
add_subdirectory(pathfinding)
add_subdirectory(shortest_paths)
add_subdirectory(largest_component)
add_subdirectory(ordering_deps)
add_subdirectory(cycle_detection)
add_subdirectory(counting_paths)
