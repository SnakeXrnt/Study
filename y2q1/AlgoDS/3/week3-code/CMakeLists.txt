cmake_minimum_required(VERSION 3.10.0)
project(week2 VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include)

include(CTest)
enable_testing()
SET(CTEST_OUTPUT_ON_FAILURE TRUE)

add_library(counter STATIC shared/counter.cpp)

add_subdirectory(selection_sort)
add_subdirectory(list_reverse)
add_subdirectory(expression_eval)
add_subdirectory(quick_sort)
add_subdirectory(merge_sort)

# Get names of all .txt files (not the full path) in the data directory
file(GLOB DATA_FILES RELATIVE ${CMAKE_SOURCE_DIR} "data/*.txt")

message(STATUS "Data files: ${DATA_FILES}")

foreach(file ${DATA_FILES})
    configure_file(${file} ${PROJECT_BINARY_DIR}/${file} COPYONLY)
endforeach()
