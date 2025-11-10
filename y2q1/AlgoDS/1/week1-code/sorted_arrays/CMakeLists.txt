set(target sorted_arrays)
add_executable(${target} main.cpp)

# add tests
add_test(NAME sorted_array_test_insert
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/insert_cases)

add_test(NAME sorted_array_test_contains
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/contains_cases)

add_test(NAME sorted_array_test_remove
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/remove_cases)
