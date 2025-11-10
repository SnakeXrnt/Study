set(target manage_bst)
add_executable(${target} main.cpp)

target_compile_options(${target} PRIVATE -Wall -Wextra -Werror -fsanitize=address -fsanitize=undefined)
target_link_options(${target} PRIVATE -fsanitize=address -fsanitize=undefined)

# add tests
add_test(NAME bst_remove_leaf_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/bst_remove_leaf_cases)

add_test(NAME bst_remove_single_child_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/bst_remove_single_child_cases)

add_test(NAME bst_remove_tricky_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/bst_remove_tricky_cases)

add_test(NAME bst_insert_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/bst_insert_cases)
