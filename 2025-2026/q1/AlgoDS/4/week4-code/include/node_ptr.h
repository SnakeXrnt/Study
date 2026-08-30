#ifndef NODE_PTR_H
#define NODE_PTR_H

#include <stack>    // for std::stack
#include "bintree.h"

namespace sax {
    template<typename T>
    class node_ptr {
    public: 
        node_ptr(binary_tree_node<T>* root) {
            push_left_path(root);
        } 
        binary_tree_node<T>* operator->() {
            return st.top();
        }

        operator bool() const {

            return !st.empty();
        }

        void move_next() {
            auto node = st.top();
            st.pop();
            if (node->right) {
                push_left_path(node->right);
            }
        }
        node_ptr& operator++() {
            move_next();
            return *this;
        }

        

    private: 
        std::stack<binary_tree_node<T>*> st;
        void push_left_path(binary_tree_node<T>* node) {
            while(node) {
                st.push(node);
                node = node->left;
            }
        }
    };
}


#endif // NODE_PTR_H
