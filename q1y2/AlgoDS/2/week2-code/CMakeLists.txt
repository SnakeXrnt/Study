cmake_minimum_required(VERSION 3.10.0)
project(week2 VERSION 0.1.0 LANGUAGES C CXX)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)

add_subdirectory(list_reverse)
add_subdirectory(list_insertions)
add_subdirectory(list_partitioning)
add_subdirectory(list_union)
add_subdirectory(unsafe_buffer)
add_subdirectory(anagrams)
add_subdirectory(subarray_sum)


