# Week 1

## Assignment 01 - Maintaining a sorted array 

My code:

```cpp
// fancy algorithm here
#include <iostream>
#include <vector>
#include "utils.h"
#include <string>


int binary_search(const std::vector<int>& vec, int value) {
    int left = 0;
    int right = vec.size();

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (vec[mid] < value) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}

void insert_number(std::vector<int>& vec, int number) {
    int pos = binary_search(vec, number);
    vec.insert(vec.begin() + pos, number); //guranteed complexity O(n) from cpprefrence

}

void remove_number(std::vector<int>& vec, int number) {
    int pos = binary_search(vec, number);
    if (vec[pos] == number) {
        vec.erase(vec.begin() + pos); //guranteed complexity O(n) from cpprefrence
    }
}

// orr, this is my own implementation of my own insert and remove

void my_insert_number(std::vector<int>& vec, int number) {
    int pos = binary_search(vec, number);

    vec.resize(vec.size() + 1); //guranteed time complexity o(n) form cpprefrence

    for (int i = vec.size() - 1; i > pos; i-- ) {
        vec[i] = vec[i - 1];
    }

    vec[pos] = number;
}

void my_remove_number(std::vector<int>& vec, int number){
    int pos = binary_search(vec, number);

    if(pos < vec.size() && vec[pos] == number) {
        for (int i = pos; i < vec.size() -1; ++i ){
            vec[i] = vec[i + 1];
        }
        vec.resize(vec.size() - 1);
    }
}

bool contains_number(const std::vector<int>& vec, int number) {
    int pos = binary_search(vec, number);
    return pos < vec.size() && vec[pos] == number;
}

int main() {
    // TODO: write a program that receives three arguments (through stdin):
    // a vector of integers, followed by a command ("insert", "remove" or "contains") and an integer
    // 

    // The output of the program must:
    //  if command is "insert" or "remove": the modified vector after applying the command
    //  if command is "contains": "true" (or "false") if the vector contains the element (or not)
    //
    // See the utils.h file for writing / reading vectors
    std::vector<int> vec;
    std::string operation;
    int number;

    // std::cout << "what do you want ([1, 2, 3, 4, 5] insert 6) : ";
    std::cin >> vec >> operation >> number;

    // std::cout << "you have give me " << vec << operation << number << std::endl;

    if (operation == "insert") {
        my_insert_number(vec, number);
        std::cout << vec << std::endl;
    } 
    else if (operation == "remove") {
        my_remove_number(vec, number);
        std::cout << vec << std::endl;
    } 
    else if (operation == "contains") {
        std::cout << (contains_number(vec, number) ? "true" : "false") << std::endl;
    } 
    else {
        std::cout << "Unknown operation." << std::endl;
    }
}

```

Time complexity: this algorithm has a time complexity of (O(log n + n)) because ......

## Assignment 02 - first occurence

My code:

```cpp
// fancy algorithm here
#include <iostream>
#include <vector>
#include "utils.h"

int main() {
    // TODO: write a program that receives two arguments over stdin, separated by spaces:
    // a vector of integers, followed by an integer to search for
    //
    // The program MUST use binary search to find the first occurrence of the integer
    // and return its index. If the integer is not found, it should return the index
    // at which the value should be inserted to maintain sorted order.

    // See the utils.h file for writing / reading vectors
    std::vector<int> vec;
    int value;

    std::cout << "gimme the vector and the integer seperated with space ~~ " << std::endl;
    std::cin >> vec >> value;

    int left = 0;
    int right = vec.size();

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (vec[mid] < value) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    if (vec[left] == value) {
        std::cout << "found!" << std::endl;
    } else {
        std::cout << "not found" << std::endl;
    }
    
    std::cout << left << std::endl;

}

```

Time complexity: this algorithm has a time complexity of (0(Log n)) because ......

## Assignment 03 - partition array 

My code:

```cpp
// fancy algorithm here
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
            std::cout << "swapping i" << arr[i] << "with" << arr[pos] << std::endl;
            if (i != pos) std::swap(arr[i], arr[pos]);
            pos++;
        }
    }

    std::cout << arr << std::endl;

    return 0;
}

```

Time complexity: this algorithm has a time complexity of 0(n) because .......
