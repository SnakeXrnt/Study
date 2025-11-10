#include <iostream>
#include <string>
#include <vector>
#include "utils.h"


size_t probe_insert(std::vector<std::string>& table, const std::string& key, size_t slots) {
    std::hash<std::string> hasher;  
    size_t idx = hasher(key) % slots;

    for (size_t i = 0; i < slots; i++) {
        size_t pos = (idx + i) % slots;

        if (table[pos] == key) {
            
            return pos;
        }
        if (table[pos] == "EMPTY") {
            table[pos] = key;
            return pos;
        }
    }
    return slots; 
}



int main() {
    /* TODO:
        Write a program that inputs an integer followed by a list of strings (given as a comma-separated list
        between square brackets, e.g. [apple, banana, cherry], use the utils.h header to read this array into a vector).

        The list represents the strings to be inserted into a hash table that uses linear probing for collision
        resolution, and the integer represents the number of slots in the hash table.

        The program must insert the strings into the hash table in the order they are given, and print the
        resulting hash table as a comma-separated list between square brackets, where empty slots are
        represented by the string "EMPTY".

        The hash table must implement a *set*, meaning that duplicate strings should not be inserted multiple
        times. In other words, if the same string appears more than once in the input list, it should only
        appear once in the output hash table.

        You must use the std::hash<std::string> struct from the C++ Standard Library to compute the hash value
        of a string. When determining whether a string is already present in the hash table, you must not search
        the entire table. Instead, you should use the same probing sequence that would be used for insertion,
        stopping when you either find the string or reach an empty slot.

        Example input:
            ((2 3 4) 5 (6 7 8)) (3 5 10)
        Example output:
            [3, 5]
    */

    
    

    int slots; 
    std::vector<std::string> strings;
    std::cin >> slots >> strings;

    std::vector<std::string> table(slots, "EMPTY");

    for (const auto& s : strings) {
        probe_insert(table, s, slots);
    }

    std::cout << "[";

    for (size_t i = 0; i < table.size(); i++) {
        std::cout << table[i];
        if (i + 1 < table.size()) {
            std::cout << ", ";

        }
    }

    std::cout << "]" << std::endl;

   
    return 0;
}
