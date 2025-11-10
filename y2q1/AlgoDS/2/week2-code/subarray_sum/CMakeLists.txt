set(target subarray_sum)
add_executable(${target} main.cpp)

target_compile_options(${target} PRIVATE -Wall -Wextra -Werror -fsanitize=address -fsanitize=undefined)
target_link_options(${target} PRIVATE -fsanitize=address -fsanitize=undefined)



# add tests
add_test(NAME subarray_sum_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/subarray_sum_cases)
