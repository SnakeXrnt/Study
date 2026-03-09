cmake_minimum_required(VERSION 3.10.0)
project(week2 VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)

add_library(nodeptr STATIC shared/node_ptr.cpp)

add_subdirectory(tree_reverse)
add_subdirectory(array_to_bst)
add_subdirectory(manage_bst)
add_subdirectory(subsets)
add_subdirectory(tree_height)
add_subdirectory(tree_slice)
add_subdirectory(tree_isect)
