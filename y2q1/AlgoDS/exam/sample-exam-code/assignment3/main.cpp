#include <iostream>
#include <ostream>
#include "bintree.h"    // for binary_tree_node
#include "utils.h"      // for reading vectors

/// Type alias for a binary tree node containing integers
using node = sax::binary_tree_node<int>;

bool are_identical(node* bst1, node* bst2) {

    if (bst1 == nullptr && bst2 == nullptr) {
        return true;
    }

    if (bst1 == nullptr || bst2 == nullptr) {
        return false;
    }

    return (bst1->data == bst2->data && are_identical(bst1->left, bst2->left) && are_identical(bst1->right, bst2->right));
}

int main() {
    // NOTE: See testing.md for instructions on how to test your solution
    //       PowerShell: Get-Content data\input1.txt | .\assignment2.exe
    //       Command Prompt: assignment1.exe < data\input1.txt
    node* bst1 = nullptr;    // pointer to the root of the first BST
    node* bst2 = nullptr;    // pointer to the root of the second BST

    // Read the binary search tree from standard input
    std::cin >> bst1 >> bst2;

    if (std::cin.fail()) {
        std::cerr << "Failed to read binary search trees from input." << std::endl;
        return 1;
    }

    // TODO: check if the two BSTs are identical

    bool answer = are_identical(bst1, bst2);

    if (answer) {
        std::cout << "identical" << std::endl;
    } else {
        std::cout << "not identical" << std::endl;
    }

    // Clean up memory
    sax::binary_tree_node<int>::cleanup(bst1);
    sax::binary_tree_node<int>::cleanup(bst2);

    return 0;
}
