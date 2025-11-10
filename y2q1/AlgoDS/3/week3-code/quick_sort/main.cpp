#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
#include <fstream>  // for std::ifstream, std::ofstream
#include "counter.h" // for sax::counter

std::vector<std::string>::iterator partition(std::vector<std::string>::iterator begin, std::vector<std::string>::iterator end) {
    if (begin == end) {
        return begin;
    }

    // Use middle element as pivot to avoid worst-case performance on sorted data
    auto middle = begin + std::distance(begin, end) / 2;
    std::swap(*middle, *(end - 1));
    sax::counter::instance().inc_swaps();

    std::string pivot = *(end - 1);

    auto i = begin;

    for (auto j = begin; j != end - 1; j++) {
        sax::counter::instance().inc_comparisons();

        if (*j <= pivot) {
            std::swap(*i, *j);
            
            sax::counter::instance().inc_swaps();

            ++i;
        }
    }

    std::swap(*i, *(end - 1));
    sax::counter::instance().inc_swaps();

    return i;

}

void quick_sort(std::vector<std::string>::iterator begin, std::vector<std::string>::iterator end) {
    if (begin == end || begin +1 == end) {
        return;
    }

    auto pivot_it = partition(begin,end);

    quick_sort(begin, pivot_it);
    quick_sort(pivot_it + 1, end);
}

int main() {
    /* TODO:
        Write a program that reads the names of two files from the standard input, 
        reads the strings from the first file into a vector, sorts the vector using quick sort,
        and then writes the sorted strings to the second file.

        When sorting the strings, the program should count the number of comparisons and swaps performed,
        and print these counts to standard output.
        
        Use the sax::counter class for this (see counter.h and counter.cpp).
    */

    std::string input_filename;
    std::string output_filename;

    std::cin >> input_filename >> output_filename;

    std::ifstream input(input_filename);
    if (!input) {
        std::cerr << "error reading input_filename" << std::endl;
        return 1;
    }

    std::vector<std::string> words;
    std::string word;
    while (input >> word) {
        words.push_back(word);
    }

    input.close();

    quick_sort(words.begin(), words.end());



    std::ofstream output(output_filename);
    if(!output) {
        std::cerr << "error reading output_filename" << std::endl;
        return 1;
    }

    for(const auto &s : words) {
        output << s << '\n';
    }

    // Print statistics
    std::cout << "Data size: " << words.size() << std::endl;
    std::cout << "Comparisons: " << sax::counter::instance().comparisons() << std::endl;
    std::cout << "Swaps: " << sax::counter::instance().swaps() << std::endl;

    return 0;
}
