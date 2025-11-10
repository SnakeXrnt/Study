
#include <algorithm>
#include <chrono>
#include <cstddef>
#include <iostream>
#include <utility>
#include "utils.h"   // for reading vectors

int main() {
    int target;
    std::vector<int> values{};
    std::cin >> values >> target;

    int size = values.size();
    
    std::pair<int, int> pointer(0,0);
    std::pair<int, int> best_pointer(0,0);

    int current_sum = 0;
    int best_diffrence = size;


    for(; pointer.second < size ; pointer.second++) {
        current_sum += values[pointer.second];
        
        
        if (current_sum > target) {
            current_sum = current_sum - values[pointer.first];
            pointer.first++;
        }

        int diffrence = std::abs(current_sum - target);
        if (diffrence < best_diffrence) {
            best_diffrence = diffrence;
            best_pointer = pointer;
        }
    }

    std::vector result(values.begin() + best_pointer.first, values.begin() + best_pointer.second+ 1 );


    // Print the result to standard output
    std::cout << result << std::endl;

    return 0;
}
