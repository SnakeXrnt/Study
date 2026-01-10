#include <vector>
#include <iostream>

int binary_search(const std::vector<int>& arr, int target) {
    int left = 0;
    int right = arr.size();

    while (left <= right) {
        int mid = left + (right - left) /2;

        if (arr[mid] == target) {
            return mid;
        } else if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return left;

}

std::vector<int> intersection(const std::vector<int>& list1, const std::vector<int>& list2) {
    std::vector<int> result;
    // TODO: Implement the intersection logic here

    for(int i = 0; i < list1.size(); i++) {
        if (binary_search(list2, list1[i]) != -1) {
            result.push_back(list1[i]);
        }
    }
    
    
    return result;
}


std::vector<int> intersection2(const std::vector<int>& list1, const std::vector<int>& list2) {
    std::vector<int> result;
    // TODO: Implement the intersection logic here

    size_t i = 0;
    size_t j = 0;

    while(i < list1.size() && j < list2.size()) {
        if (list1[i] < list2[j]) {
            i++;
        } else if (list1[i] > list2[j]) {
            j++;
        } else {
            result.push_back(list1[i]);
            i++;
            j++;
        }
    }



    return result;
}

int main() {
    std::vector<int> a = {1, 3, 4, 7, 10};
    std::vector<int> b = {3, 5, 7, 9, 10};
    
    // Expected output: 3 7 10
    std::vector<int> result = intersection2(a, b);
    
    for(int x : result) std::cout << x << " ";
    return 0;
}