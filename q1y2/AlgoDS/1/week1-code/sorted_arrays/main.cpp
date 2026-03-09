#include <iostream>
#include <numbers>
#include <vector>
#include "utils.h"
#include <string>

int binary_search(std::vector<int>& vec, int number) {
    int left = 0;
    int right = vec.size();
    
    while(left < right) {
        int mid = left + (right - left) / 2;
        if (vec[mid] < number) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}

void insert_value(std::vector<int>& vec, int number) {
    int location = binary_search(vec,number);
    printf("binary search result : %d \n", location);
    vec.insert(vec.begin() + location, number);
}


void remove_value(std::vector<int>& vec, int number) {
    int location = binary_search(vec,number);
    printf("binary search result : %d \n", location);
    vec.erase(vec.begin() + location);
}

bool membership_test(std::vector<int>& vec, int number) {
    int location = binary_search(vec,number);
    printf("binary search result : %d \n", location);
    if (location == static_cast<int>(vec.size())) return false;
    return vec[location] == number;
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

    std::vector<int> lists;
    std::string op; 
    int numbers; 

    std::cin >> lists >> op >> numbers; 

    if ("insert" == op) {
        printf("inserting operator \n");
        insert_value(lists, numbers);
        std::cout << lists << std::endl;
    } else if ("remove" == op) {
        printf("removing operator \n");
        remove_value(lists, numbers);
        std::cout << lists << std::endl;
    } else if ("contains" == op) {
        printf("membership testing \n");
        bool result = membership_test(lists, numbers);
        if (result) {
            printf("found");
        } else {
            printf("not found");
        }

    }

    
}
