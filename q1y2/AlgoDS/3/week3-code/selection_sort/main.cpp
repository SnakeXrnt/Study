#include <iostream>
#include <string>
#include <vector>
#include <fstream>  // for std::ifstream, std::ofstream
#include <iomanip>  // for std::quoted
#include "counter.h" // for sax::counter

/// @brief Sorts a vector of strings using selection sort:
///        Finds the smallest value in the unsorted part, and swaps it with
///        the first value in the unsorted part, iteratively expanding
///        the sorted part.
/// @param begin Iterator to the first element in the vector
/// @param end   Iterator to one past the last element in the vector
void selection_sort(std::vector<std::string>::iterator begin, 
                    std::vector<std::string>::iterator end) {
    // obtain an iterator to the first value
    while (begin != end) {
        auto smallest = begin; // pointer to smallest value found so far
        auto next = begin + 1; // pointer to the first value after it
        while (next != end) {   // while we haven't reached the end
            // compare the value pointed to by next with the value pointed to by smallest
            // if next points to a smaller value than the one pointed to by smallest, 
            // updated smallest so that it again points to the smallest value found so far
            if (*next < *smallest) smallest = next;

            // increment comparisons counter
            sax::counter::instance().inc_comparisons();

            ++next; // point to next value
        }
        // smallest now points to the smallest value, so put it at the location
        // pointed to by begin
        std::swap(*begin, *smallest);

        // increment swaps counter
        sax::counter::instance().inc_swaps();

        ++begin;   // point to next value
    }
}

int main() {
    /* TODO:
        Write a program that reads the names of two files from the standard input, 
        reads the strings from the first file into a vector, sorts the vector using selection sort,
        and then writes the sorted strings to the second file.

        When sorting the strings, the program should count the number of comparisons and swaps performed,
        and print these counts to standard output.
        
        Use the sax::counter class for this (see counter.h and counter.cpp).
    */

    // Strings for holding the names of the input & output file:
    std::string input_name, output_name;
    std::getline(std::cin, input_name);
    std::getline(std::cin, output_name);

    // open input file
    std::ifstream input_file{input_name};
    if (!input_file) {
        std::cerr << "Error opening input file named " << std::quoted(input_name) << std::endl;
        return 1;
    }

    // read input data into vector
    std::vector<std::string> data;
    std::string value;
    while (input_file >> value) {
        data.push_back(value);
    }
    input_file.close();

    // sort the data
    selection_sort(data.begin(), data.end());

    // write output file
    std::ofstream output_file{output_name};
    if (!output_file) {
        std::cerr << "Error opening output file named " << std::quoted(output_name) << std::endl;
        return 1;
    }

    for (const auto& v : data) {
        output_file << v << ' ';
    }

    // write size of data, number of comparisons and swaps
    std::cout << "Data size: " << data.size() << std::endl;
    std::cout << "Comparisons: " << sax::counter::instance().comparisons() << std::endl;
    std::cout << "Swaps: " << sax::counter::instance().swaps() << std::endl;

    return 0;
}
