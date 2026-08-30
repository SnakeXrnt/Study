#include <algorithm>
#include <chrono>
#include <cstddef>
#include <iostream>
#include <utility>
#include <vector>
#include "utils.h"   // for reading vectors

int main() {
    int target;
    std::vector<int> values{};
    std::cin >> values >> target;

    int size = values.size();

    std::pair<int, int> window(0,0);
    std::pair<int, int> best_window(0,0);

    int best_diffrence = 999999;

    int current_sum = 0;

    for (; window.second < size ; window.second++) {
        current_sum += values[window.second];

        if (current_sum > target) {
            current_sum -= values[window.first];
            window.first++;
        }

        int diffrence = std::abs(current_sum - target);
        if (diffrence < best_diffrence) {
            best_diffrence = diffrence;
            best_window = window;
        }
    }

    std::vector result(values.begin() + best_window.first, values.begin() + best_window.second + 1);

    // Print the result to standard output
    std::cout << result << std::endl;

    return 0;
}
