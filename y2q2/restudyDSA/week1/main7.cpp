#include <iostream>

int factorial(int n) {
    // 1. TODO: The Base Case (When do we stop?)

    if (n <= 1) {
        return 1;
    }
    int result = n * factorial(n - 1);
    
    // 2. TODO: The Recursive Step (The magic)
    return result; // Change this!
}

int main() {
    std::cout << "5! should be 120: " << factorial(5) << std::endl;
    std::cout << "3! should be 6: " << factorial(3) << std::endl;
    return 0;
}