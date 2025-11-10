cmake_minimum_required(VERSION 3.10.0)
project(week1 VERSION 0.1.0 LANGUAGES C CXX)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)


add_subdirectory(first_occurrence)
add_subdirectory(intersect_sets)
add_subdirectory(partition_array)
add_subdirectory(sorted_arrays)
add_subdirectory(subtract_sets)
add_subdirectory(subtract_sets_inplace)
