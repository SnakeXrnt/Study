#include <iostream>
#include "bintree.h"

void print_reverse_sorted(sax::binary_tree_node<int>* node) {
    if (node == nullptr) return;
    print_reverse_sorted(node->right);
    std::cout << node->data << " ";
    print_reverse_sorted(node->left);
}

int main()
{
    /* TODO:
        Write a program that reads a binary search tree from the standard input,
        followed by an integer k, and prints all elements in the tree that are less than or equal to k,
        in sorted order.
        The time complexity of your program should be O(n), where n is the number of nodes in the tree.
        Your program must not make use of more than O(h) memory, where h is the height of the tree.

        Example input: ((1 3 4) 5 (7 8 ())) 5
        Example output: 1 3 4 5

        Use the binary_tree_node struct from bintree.h to represent the tree. This structure already
        contains input and output operators that you can use to read (and write) trees.

        Use the node_ptr class from node_ptr.h to traverse the tree.
    */

    sax::binary_tree_node<int>* root = nullptr;
    std::cin >> root;

    // Print the values in reverse sorted order
    print_reverse_sorted(root);
    std::cout << std::endl;

    sax::binary_tree_node<int>::cleanup(root);

    return 0;
}
