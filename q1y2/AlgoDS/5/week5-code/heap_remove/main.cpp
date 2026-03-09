#include <algorithm>
#include <functional>
#include <iostream>
#include <vector>
#include "utils.h"

void sift_down(std::vector<int>& heaps, int i) {
    size_t n = heaps.size();
    while (true) {
        int smallest= i;
        size_t left = 2*i + 1;
        size_t right = 2*i + 2;
        
        if (left < n && heaps[left] < heaps[smallest]) smallest = left;
        if (right < n && heaps[right] < heaps[smallest]) smallest = right;

        if (smallest == i) break;

        std::swap(heaps[i], heaps[smallest]);
        i = smallest;   
    }
}


void sift_up(std::vector<int>& heap, size_t i) {
    while (i > 0) {
        size_t parent = (i - 1) / 2;
        if (heap[i] < heap[parent]) {
            std::swap(heap[i], heap[parent]);
            i = parent;
        } else {
            break;
        }
    }
}

int main() {
    /* TODO:
        Write a program that reads a binary *min-heap* from its standard input, given as an array,
        and an integer that represents a value to be removed from the heap.

        The program must remove the specified value from the heap while maintaining the heap
        property, and print the resulting heap in the same format as the input. If the value
        is not present in the heap, the program must print the original heap unchanged.

        Example input:
            [3, 4, 10, 23, 50, 90] 50
        Example output:
            [3, 4, 10, 23, 90]
    */
   
    std::vector<int> heaps;
    int toremove;
 
    std::cin >> heaps >> toremove;

   
    auto where = std::find(heaps.begin(), heaps.end(), toremove);
    if (where != heaps.end()) {
        size_t id_where = where - heaps.begin();
        std::swap(heaps[id_where], heaps.back());
        heaps.pop_back();

        
    if (id_where < heaps.size()) {
        if (id_where > 0 && heaps[id_where] < heaps[(id_where-1)/2])
            sift_up(heaps, id_where);
        else
            sift_down(heaps, id_where);
}

    }

    
    

    std::cout << heaps << std::endl;
    return 0;

}
