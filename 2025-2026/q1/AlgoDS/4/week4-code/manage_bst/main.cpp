#include <algorithm>
#include <cinttypes>
#include <cstdio>
#include <iostream>
#include <string>
#include "bintree.h"

sax::binary_tree_node<int> * insert (sax::binary_tree_node<int> * root, int value) {
    
    if(root == nullptr) {
        return new sax::binary_tree_node<int>{value, nullptr, nullptr};
    }

    if (value < root->data) {
        root->left = insert(root->left, value);
    } else if (value > root->data) {
        root->right = insert(root->right, value);
    } else {
        return root;
    }

    return root;
}

sax::binary_tree_node<int> * find_min(sax::binary_tree_node<int> * root) {
    while (root->left != nullptr) {
        root = root->left;
    }
    return root;
}

sax::binary_tree_node<int> * remove (sax::binary_tree_node<int> * root, int value) {
    


    if (root==nullptr) {
        return nullptr;
    }
    if (value < root->data) {
        root->left = remove(root->left, value);
    } else if (value > root->data) {
        root->right = remove(root->right, value);
    } else {
        if(root->right == nullptr && root->left == nullptr){
            delete root;
            return nullptr;
        }
        if (root->right == nullptr) {
            sax::binary_tree_node<int> * temp = root->left;
            delete root;
            return temp;
        }
        if (root->left == nullptr) {
            sax::binary_tree_node<int> * temp = root->right;
            delete root;
            return temp;
        }

        auto min_node = find_min(root->right);
        root->data = min_node->data;
        root->right = remove(root->right, min_node->data);


    }


    return root;
}

int main() {
    /* TODO:
    Write a program that reads a binary search tree with integers from the standard input,
    followed by a command to either insert or delete an integer from the tree.
    The program should then perform the specified operation and print the resulting tree.
    */

    sax::binary_tree_node<int>* root = nullptr;
    std::string command;
    int value;
    std::cin >> root >> command >> value;

    if (command == "insert") {
        root = insert(root,value);
    } else if (command == "remove") {
        root = remove(root,value);
    }

    std::cout << root << std::endl;
    sax::binary_tree_node<int>::cleanup(root);
    return 0;
} 
