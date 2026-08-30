#include <iostream>
#include <vector>
#include "utils.h"

int main() {
    // TODO: write a program that receives three arguments over stdin, separated by spaces:
    // a vector of integers, followed by the word "move" and an integer
    // The program must partition the array so that all occurences of the integer
    // are placed at the end of the array.
    // Use the two-pointer technique and element swapping for this
    // See the utils.h file for writing / reading vectors

    std::vector<int> arr;
    int value;

    std::cout << "Enter array and value to move to end (e.g. [3, 1, 2, 3, 4, 3, 5] 3): ";
    std::cin >> arr >> value;
// [3, 1, 2, 3, 4, 3, 5, 6] 6
    int pos = 0; // placement pointer
    for (int i = 0; i < arr.size(); i++) {
        if (arr[i] != value) {
            std::cout << "arr i != value" << std::endl;
            //if (i != pos) {
                std::swap(arr[i], arr[pos]);
                std::cout << "swapping i" << arr[i] << "with" << arr[pos] << std::endl;
            //}
            pos++;
        }
    }

    std::cout << arr << std::endl;

    return 0;
}
