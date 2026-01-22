#include <iostream>
#include "linked_list.h"
#include "utils.h"   // for reading vectors

using node = sax::linked_list_node<int>;

/// @brief Splits the linked list into two lists: one containing the even values, and one containing the odd values.
/// @param head The head of the original linked list. After the function returns, this list will contain only the odd values.
/// @return The list containing the even values. The original list (pointed to by head) will contain the odd values after the function returns.
node* split_even(node*& head) {

    node sentinel_even{}, sentinel_odd{};
    node *even_tail = &sentinel_even;
    node *odd_tail = &sentinel_odd;

    while (head) {

        if (head->data % 2 == 0) {
            even_tail->next = head;
            even_tail = even_tail->next;
        } else {
            odd_tail->next = head;
            odd_tail = odd_tail->next;
        }

        head = head->next;
    }

    even_tail->next = nullptr;
    odd_tail->next = nullptr;


    head = sentinel_odd.next;
    return sentinel_even.next;
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

    // TODO: Split the list into odd and node 

    node * even = split_even(head);

    std::cout << "odd : " << head << "\n" << "even : " << even << "\n" << std::endl;



    // Clean up memory (TODO: don't forget to clean up the new list you create as well)
    node::cleanup(head);
    node::cleanup(even);

    return 0;
}
