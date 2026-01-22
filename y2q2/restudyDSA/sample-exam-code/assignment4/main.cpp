#include <iostream>
#include "utils.h"

int main() {
    // NOTE: See testing.md for instructions on how to test your solution
    //       PowerShell: Get-Content data\input1.txt | .\assignment4.exe
    //       Command Prompt: assignment1.exe < data\input1.txt
    std::vector<std::pair<char, char>> edges;
    std::cin >> edges;

    if (std::cin.fail()) {
        std::cerr << "Failed to read graph edges from input." << std::endl;
        return 1;
    }

    // TODO: Find cycle in the directed graph represented by edges

    return 0;
}
