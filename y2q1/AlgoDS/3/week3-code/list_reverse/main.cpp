#include <algorithm>
#include <iostream>
#include "linked_list.h"

sax::linked_list_node<std::string> * reverse(sax::linked_list_node<std::string> * unreversed) {
    if (unreversed == nullptr || unreversed->next ==nullptr) {
        return  unreversed;
    }

    sax::linked_list_node<std::string> * reversed = reverse(unreversed->next);

    unreversed->next->next = unreversed;
    unreversed->next = nullptr;
 
    return reversed;

}

int main() {
    /* TODO:
        Write a program that reads a singly linked list of strings from standard input,
        reverses the list using recursion, and prints the reversed list to standard output.

        Example input: [apple -> banana -> cherry -> blueberry]
        Example output: [blueberry -> cherry -> banana -> apple]
    */
    sax::linked_list_node<std::string> *head = nullptr;

    std::cin >> head;

    if (!std::cin) {
        std::cerr << "i failed because of you" << std::endl;
        sax::linked_list_node<std::string>::cleanup(head);
    }

    if (head == nullptr) {
        std::cout << "[]" << std::endl;
        return 0;
    }

    sax::linked_list_node<std::string> * reversed = reverse(head);

    std::cout << reversed << std::endl;
    sax::linked_list_node<std::string>::cleanup(reversed);
    // sax::linked_list_node<std::string>::cleanup(head);

    


    return 0;
}
