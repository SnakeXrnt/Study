#include <iostream>
#include "utils.h"

int main()
{
    /* TODO:
        Write a program that reads a integer followed by a list of strings from its standard input (given as a
        comma-separated list between square brackets, e.g. `[apple,banana,cherry]` - see week 1).

        The list represents the strings to be inserted into a hash table that uses *separate chaining* for
        collision resolution, and the integer represents the number of slots in the hash table.

        The program must insert the strings into the hash table in the order they are given, and print the
        resulting hash table as a comma-separated list between square brackets, where each slot is printed
        as a linked list in the form `[<string1> -> <string2> -> ...]` (empty slots will be represented by
        a pair of brackets, i.e. "[]").

        The hash table must implement a *set*, meaning that duplicate strings should not be inserted multiple
        times. In other words, if the same string appears more than once in the input list, it should only
        appear once in the output hash table.

        To determine the index for a string, you *must* use the `std::hash<std::string>` struct from the C++
        Standard Library to compute the hash value of the string.

        When determining whether a string is already present in the hash table, you must not search the entire
        table. Instead, you should use the same probing sequence that would be used for insertion, stopping
        when you either find the string or reach the end of the linked list.
    */

    // Hint: use a vector of singly linked lists as the underlying data structure for the hash table.
    
    return 0;
}
