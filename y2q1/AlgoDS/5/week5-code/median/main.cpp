#include <iostream>
#include <algorithm>
#include "utils.h"
#include <vector>
#include <queue>

int main()
{
    std::priority_queue<int> max_heap;

    std::priority_queue<int, std::vector<int>, std::greater<int>> min_heap;

    int number;
    bool first = true;

    while (std::cin >> number)
    {
        if (max_heap.empty() || number <= max_heap.top())
        {
            max_heap.push(number);
        }
        else
        {
            min_heap.push(number);
        }

        if (max_heap.size() > min_heap.size() + 1)
        {
            min_heap.push(max_heap.top());
            max_heap.pop();
        }
        else if (min_heap.size() > max_heap.size())
        {
            max_heap.push(min_heap.top());
            min_heap.pop();
        }

        double median;
        if (max_heap.size() == min_heap.size())
        {
            median = (max_heap.top() + min_heap.top()) / 2.0;
        }
        else
        {
            median = max_heap.top();
        }
        if (!first)
        {
            std::cout << " ";
        }
        first = false;

        std::cout << median;
    }
    std::cout << std::endl;

    return 0;
}
