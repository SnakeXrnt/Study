cmake_minimum_required(VERSION 3.32)

project(Assignment_2)

add_executable(rpn_calc)

target_sources(rpn_calc PRIVATE 
    main.cpp
)

target_include_directories(rpn_calc PRIVATE include)

target_compile_features(rpn_calc PRIVATE cxx_std_23)
target_compile_options(rpn_calc PRIVATE -Wall -Wextra -pedantic -Werror )

target_compile_options(rpn_calc PRIVATE -fsanitize=address,undefined -fno-omit-frame-pointer)
target_link_options(rpn_calc PRIVATE -fsanitize=address,undefined)