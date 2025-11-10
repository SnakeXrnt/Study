set(target first_occurrence)
add_executable(${target} main.cpp)

# add tests
add_test(NAME first_occurrence_test
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/scripts/test_target.py ${target} ${CMAKE_CURRENT_SOURCE_DIR}/tests/first_occurrence_cases)
