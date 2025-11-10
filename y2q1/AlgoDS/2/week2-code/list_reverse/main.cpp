#include <iostream>
#include "linked_list.h"

int main() {
    /* TODO:
        Write a program that reads a singly linked list of strings from standard input,
        reverses the list, and prints the reversed list to standard output.

        Example input: [apple -> banana -> cherry -> blueberry]
        Example output: [blueberry -> cherry -> banana -> apple]
    */

    // This is how you read a singly linked list from standard input:
    // you need to provide an address of a pointer to a node,
    // and then the stream input operator (>>) will allocate the nodes and set the pointer to point to the head node.
    sax::linked_list_node<std::string> *head = nullptr;
    std::cin >> head;
    if (!std::cin) {
        std::cerr << "Failed to read list from input." << std::endl;

        // in case some memory was allocated before the failure, we need to clean it up
        // the cleanup function can handle a nullptr input, so it's safe to call even if head is still nullptr
        sax::linked_list_node<std::string>::cleanup(head);
        return 1;
    }

    // if the list is empty, the head pointer will be nullptr
    if (head == nullptr) {
        std::cout << "[]" << std::endl; // Empty list
        return 0;
    }

    // Reversing the list:
    // - the approach that we follow here is to go over the nodes in the list, and then prepend each node to a new list, effectively reversing the order
    // - initially, the new list is just the head node, and then we go over the remaining nodes one by one, prepending each to the new list
    sax::linked_list_node<std::string> *new_head = head;
    sax::linked_list_node<std::string> *next = head->next;
    new_head->next = nullptr; // new list is initially just the head node

    // while we have not reached the end of the original list
    while (next != nullptr) {
        // obtain a pointer to the node after next (i.e. next->next) and store it for later use
        sax::linked_list_node<std::string> *temp = next->next;

        // insert next node at the front of the new list, i.e. set its next to new_head, then update new_head to point to next
        next->next = new_head;
        new_head = next;

        // move to the next node in the original list
        next = temp;
    }

    // Now new_head points to the head of the reversed list
    // Print the reversed list
    std::cout << *new_head << std::endl; // Print the list

    // Clean up memory, note that we must now use new_head as the head of the reversed list
    sax::linked_list_node<std::string>::cleanup(new_head);

    return 0;
}
