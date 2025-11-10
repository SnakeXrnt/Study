#include <iostream>
#include <string>
#include "bintree.h" // for binary_tree_node
#include "node_ptr.h"

bool is_subset(sax::binary_tree_node<int>*one, sax::binary_tree_node<int>*two) {
    sax::node_ptr<int> itone(one);
    sax::node_ptr<int> ittwo(two);

    while (itone && ittwo) {
        if (itone->data < ittwo->data) {
            return false;
        } else if (itone->data > ittwo->data) {
            ++ittwo;
        } else {
            ++itone;
            ++ittwo;
        }
    }

    return !itone;
}

int main() {
    /* TODO:
        Write a program that reads two binary search trees from standard input, which represent sets of
        integers (no duplicates within each tree), and checks if the first one is a subset of the second one.

        The program must output "true" if the first tree is a subset of the second one, and "false" otherwise.

        The time complexity of your program must be O(n + m), where n and m are the sizes of the two trees.
    */

    sax::binary_tree_node<int> * one = nullptr;
    sax::binary_tree_node<int> * two = nullptr;

    std::cin >> one >> two;

    sax::node_ptr<int> itone(one);
    sax::node_ptr<int> ittwo(two);


    bool result = is_subset(one,two);
    std::cout << (result ? "true" : "false") << std::endl;
    
    sax::binary_tree_node<int>::cleanup(one);
    sax::binary_tree_node<int>::cleanup(two); 


    return 0;
}
