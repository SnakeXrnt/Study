set(target list_insertions)
add_executable(${target} main.cpp)

target_compile_options(${target} PRIVATE -Wall -Wextra -Werror -fsanitize=address -fsanitize=undefined)
target_link_options(${target} PRIVATE -fsanitize=address -fsanitize=undefined)



# add tests
add_test(NAME list_insertions_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/list_insertions_cases)
