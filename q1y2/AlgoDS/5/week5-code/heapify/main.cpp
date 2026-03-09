#include "utils.h" // for reading vectors
#include <array>
#include <iostream>
#include <vector>

void sift_down(std::vector<int> &heaps, int i, int &swap_count) {
  size_t n = heaps.size();
  while (true) {
    int smallest = i;
    size_t left = 2 * i + 1;
    size_t right = 2 * i + 2;

    if (left < n && heaps[left] < heaps[smallest])
      smallest = left;
    if (right < n && heaps[right] < heaps[smallest])
      smallest = right;

    if (smallest == i)
      break;

    std::swap(heaps[i], heaps[smallest]);
    swap_count++;
    i = smallest;
  }
}

// i dont think i need this, but oh well
void sift_up(std::vector<int> &heap, size_t i) {
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
      Write a program that reads an array from its standard input, given as an
     array between square brackets (e.g. `[1,3,5,7,9]` - see week 1), and prints
     the number of *swaps* that would be performed when turning this array into
     a valid binary *min-heap* using the `std::make_heap` function from the C++
     Standard Library.

      You can't use the `std::make_heap` function directly, instead you must
     implement the heapify algorithm as described in the lecture, and count the
     number of swaps performed during the process.

      The time complexity of your solution must be O(n), where n is the number
     of elements in the input array.

      Example input:
          [1, 5, 6, 2, 3, 4, 7]
      output:
          2
  */
  std::vector<int> input;
  std::cin >> input;

  int swap_count = 0;
  size_t input_size = input.size();

  for (int i = input_size / 2 - 1; i >= 0; i--) {
    sift_down(input, i, swap_count);
  }

  std::cout << swap_count << std::endl;
  return 0;
}
