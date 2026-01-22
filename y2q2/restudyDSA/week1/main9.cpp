#include <iostream>

int fib(int n) {
    // 1. Base Case: If n is 0 or 1, return n.
    // (Or return 0 if n=0, return 1 if n=1)

    if(n == 0 || n == 1) {
        return n;
    }

    
    // 2. Recursive Step: Return the sum of the previous two
    int result = fib(n - 1) + fib(n - 2);
    return result; // Change this
}

int main() {
    // Sequence: 0, 1, 1, 2, 3, 5, 8, 13...
    std::cout << "fib(6) should be 8: " << fib(6) << std::endl;
    std::cout << "fib(7) should be 13: " << fib(7) << std::endl;
    return 0;
}