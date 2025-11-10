#ifndef BINTREE_H
#define BINTREE_H

#include <sstream>

namespace sax {
    /* A node in a binary tree that can contain data of generic type T */
    template<typename T>
    struct binary_tree_node {
        // Members:
        T data{};                           // The data kept in the node
        binary_tree_node *left{};          // Pointer to the left child (nullptr if there is no left child)
        binary_tree_node *right{};         // Pointer to the right child (nullptr if there is no right child)


        // Recursively cleans up the head node and all nodes reachable from head
        static void cleanup(binary_tree_node *head) {
            if (head == nullptr) return;
            cleanup(head->left);
            cleanup(head->right);
            delete head;
        }

        static binary_tree_node* copy(const binary_tree_node* head) {
            if (head == nullptr) return nullptr;
            return new binary_tree_node{head->data, copy(head->left), copy(head->right)};
        }

        // courtesy output operator for binary_tree_node
        friend std::ostream &operator<<(std::ostream &os, const binary_tree_node<T> *head) {
            if (head == nullptr) return os << "()";
            else if (head->left == nullptr && head->right == nullptr) return os << head->data;
            else return os << "(" << head->left << " " << head->data << " " << head->right << ")";
        }

        friend std::ostream &operator<<(std::ostream &os, const binary_tree_node<T> &head) {
            return os << &head;
        }

        // courtesy input operator for binary_tree_node
        // Reads the first tree from the input stream and stores it in head.
        //  A tree can either be empty
        friend std::istream &operator>>(std::istream &is, binary_tree_node<T>* &head) {

            // Clear existing tree
            if (head != nullptr) cleanup(head);
            head = nullptr;
            
            if ((is >> std::ws).eof() || is.fail()) {
                // nothing to read
                return is;
            }

            // Read new tree
            char next_char = (is >> std::ws).peek();
            if (next_char != '(') {
                // it's not an opening bracket, so it must be a value
                head = new binary_tree_node<T>();
                if (!(is >> head->data)) {
                    is.setstate(std::ios::failbit);
                }
            }
            else {
                is.get(); // consume the opening bracket
                // peek next char to see if it's a closing bracket
                next_char = (is >> std::ws).peek();
                if (next_char == ')') {
                    // empty tree
                    head = nullptr;
                    is.get(); // consume the closing bracket
                }
                else {
                    // not an empty tree, so we proceed to read left subtree, data, right subtree, and closing bracket
                    // allocate new node
                    head = new binary_tree_node<T>();
                    if (is >> head->left >> head->data >> head->right) {
                        // consume closing bracket
                        if (!(is >> next_char) || next_char != ')') {
                            is.setstate(std::ios::failbit);
                        }
                    }
                }
            }

            return is;
        }
    };
}   // namespace sax

#endif // BINTREE_H