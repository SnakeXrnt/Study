#include <iostream>
#include "linked_list.h"
#include "utils.h"   // for reading vectors

using node = sax::linked_list_node<int>;

/// @brief Splits the linked list into two lists: one containing the even values, and one containing the odd values.
/// @param head The head of the original linked list. After the function returns, this list will contain only the odd values.
/// @return The list containing the even values. The original list (pointed to by head) will contain the odd values after the function returns.
node* split_even(node*& head) {
    node * temp = head;
    node * previous_temp = nullptr;
    node * even = nullptr;
    node * temp_even = nullptr;

    while (temp != nullptr) {
        node * next_temp = temp->next;
        if(temp->data % 2 == 0) {
            if (previous_temp != nullptr) {
                previous_temp->next = next_temp;
            } else {
                head = next_temp;
            }

            temp->next = nullptr;

            if (even != nullptr) {
                temp_even->next = temp;
                temp_even = temp;
            } else {
                temp_even = temp;
                even = temp;
            }
            
            
        } else {
            previous_temp = temp;
        }
        temp = next_temp;
    }

    return even;
}


node * split_even2(node*& head) {
    node * temp = head;
    node * previous_temp = nullptr;
    
    node * even= nullptr;
    node * even_temp = nullptr;

    while(temp != nullptr) {
        node* next_temp = temp->next;
        if (temp->data % 2 == 0) {
            if (previous_temp != nullptr) {
                previous_temp->next = next_temp;
            } else {
                head = next_temp;
            } 

            temp->next = nullptr;

            if (even != nullptr) {
                even_temp->next = temp;
            } else {
                even = temp;
            }

            even_temp = temp;
        } else {
            previous_temp = temp;
        }
        temp = next_temp;
    }
    return even;
}


int main() {
    node* head = nullptr;

    // Read the binary search tree from standard input
    std::cin >> head;

    std::cout << "Input Linked List: " << head << std::endl;

    if (std::cin.fail()) {
        std::cerr << "Failed to read linked list from input." << std::endl;
        return 1;
    }

    // TODO: Split the list into odd and even_temp
    node* even = split_even2(head);

    std::cout << "even: " << even << std::endl;
    std::cout << "odd : " << head << std::endl;

    // Clean up memory (TODO: don't forget to clean up the new list you create as well)
    node::cleanup(head);
    node::cleanup(even);

    return 0;
}
