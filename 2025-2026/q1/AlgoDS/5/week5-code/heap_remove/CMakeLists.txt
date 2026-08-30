set(target heap_remove)
add_executable(${target} main.cpp)

target_compile_options(${target} PRIVATE -Wall -Wextra -Werror -fsanitize=address -fsanitize=undefined)
target_link_options(${target} PRIVATE -fsanitize=address -fsanitize=undefined)

# add tests
set(test_name ${target}_test)

add_test(NAME ${test_name}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/${test_name}_cases)
