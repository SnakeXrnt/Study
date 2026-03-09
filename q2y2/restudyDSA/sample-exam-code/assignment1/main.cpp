#include <iostream>
#include "utils.h"   // for reading vectors



int main() {
    int target;
    std::vector<int> values{};

    std::cin >> values >> target;

    
    int left = 0, right = 0;
    int sum = 0;
    int best_gap = target;
    int best_left = 0, best_right = 0;

    while (right < values.size()) {

        if (sum < target) {
            sum += values[right++];
        } else {
            sum -= values[left++];
        }

        int gap = std::abs(target - sum);
        if (gap < best_gap) {
            best_gap = gap;
            best_left = left;
            best_right = right;
        }
    }


    std::vector<int> result{values.begin() + best_left, values.begin() + best_right};
    int best_sum = 0;

    for(int k = 0; k <  result.size() ; k++) {
        best_sum += result[k];
    }


    

    // Print the result to standard output
    std::cout << result <<  " " << best_sum << std::endl;

    return 0;
}
