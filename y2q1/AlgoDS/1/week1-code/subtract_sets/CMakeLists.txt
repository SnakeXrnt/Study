set(target subtract_sets)
add_executable(${target} main.cpp)

# add tests
add_test(NAME subtract_sets_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/subtract_sets_cases)
