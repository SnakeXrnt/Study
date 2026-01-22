## Change the name of the target in case you're having problems building your program after a crash
set(target assignment1)

add_executable(${target} main.cpp)

target_compile_options(${target} PRIVATE -Wall -Wextra -Wpedantic)

configure_file(data/input1.txt data/input1.txt COPYONLY)
configure_file(data/input2.txt data/input2.txt COPYONLY)
configure_file(data/input3.txt data/input3.txt COPYONLY)
