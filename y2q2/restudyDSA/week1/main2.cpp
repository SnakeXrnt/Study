#include <vector>
#include <iostream>

// TODO: Modify this to return the 'insertion index' if not found
size_t find_insertion_index(const std::vector<int>& arr, int target) {
    size_t left = 0;
    size_t right = arr.size(); // Note: Use size(), not size()-1, to handle end insertion

    while (left < right) {
        size_t mid = left + (right - left) / 2;

        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left; // This is the magic spot!
}

size_t binary_search(const std::vector<int>& arr, int target) {
    size_t left = 0;
    size_t right = arr.size();

    while (left < right) {
        size_t mid = left + (right - left) /2;

        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;

}

void insert_sorted(std::vector<int>& vec, int value) {
    // 1. Find the index
    size_t index = binary_search(vec, value);
    
    // 2. Insert the value at that index
    // TODO: Use vec.insert() here

    vec.insert(vec.begin() + index, value);
}

int main() {
    std::vector<int> data = {1, 3, 5, 7};
    
    insert_sorted(data, 4); // Should go between 3 and 5
    insert_sorted(data, 0); // Should go at the start
    insert_sorted(data, 9); // Should go at the end

    for(int x : data) std::cout << x << " "; 
    // Expected: 0 1 3 4 5 7 9
    return 0;
}