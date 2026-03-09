cmake_minimum_required(VERSION 3.10.0)
project(sample_exam VERSION 0.1.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(include)

add_subdirectory(assignment1)
add_subdirectory(assignment2)
add_subdirectory(assignment3)
add_subdirectory(assignment4)
