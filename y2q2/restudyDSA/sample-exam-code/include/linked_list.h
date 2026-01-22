#ifndef LINKED_LIST_H
#define LINKED_LIST_H

#include <sstream>

namespace sax {
    /* A node in a singly linked list that can contain data of generic typc T */
    template<typename T>
    struct linked_list_node {
        // Members:
        T data{};                   // The data kept in the node
        linked_list_node *next{};   // Pointer to the next node (nullptr if there is no next node)


        // Cleans up the head node and all nodes reachable from head
        static void cleanup(linked_list_node *head) {
            linked_list_node<T> *current = head;
            while (current != nullptr) {
                linked_list_node<T> *next = current->next;
                delete current;
                current = next;
            }
        }

        // courtesy output operator 
        friend std::ostream &operator<<(std::ostream &os, const linked_list_node<T> *head) {
            return os << *head;
        }
        
        friend std::ostream &operator<<(std::ostream &os, const linked_list_node<T> &head) {
            const linked_list_node<T> *current = &head;
            os << "[";
            while (current != nullptr) {
                os << current->data;
                if (current->next != nullptr) {
                    os << " -> ";
                }
                current = current->next;
            }
            os << "]";
            return os;
        }

        // courtesy input operator for SinglyLinkedListNode
        friend std::istream &operator>>(std::istream &is, linked_list_node<T>* &head) {
            return is >> &head;
        }

        friend std::istream &operator>>(std::istream &is, linked_list_node<T> **head) {
            // Clear existing list
            linked_list_node<T> *current = *head;
            while (current != nullptr) {
                linked_list_node<T> *next = current->next;
                delete current;
                current = next;
            }
            *head = nullptr;

            // Read new list
            char opening_char;
            is >> opening_char;
            if (opening_char != '[') {
                is.setstate(std::ios::failbit);
                return is;
            }

            // Read until closing bracket
            std::string list_str;
            std::getline(is, list_str, ']');
            std::istringstream list_stream(list_str);

            linked_list_node<T> **last = head;

            linked_list_node<T> *new_node = new linked_list_node<T>{};
            if (list_stream >> new_node->data) {
                *last = new_node;
                last = &new_node->next;

                // read and discard the arrow delimiter if present
                std::string delimiter;
                while (list_stream >> delimiter && delimiter == "->") {
                    // Continue to the next element
                    new_node = new linked_list_node<T>{};
                    if (!(list_stream >> new_node->data)) {
                        delete new_node;            // failed to read data, clean up
                        is.setstate(std::ios::failbit);
                        return is;
                    }
                    // append new node to the list
                    *last = new_node;
                    last = &new_node->next;
                }
                // no more elements or delimiter not "->"
                if (!list_stream.eof()) {
                    // fail to read till end of stream
                    is.setstate(std::ios::failbit);
                }
            } else if (list_stream.eof()) {
                // No elements, just return
                delete new_node;
            } else {
                // Failed to read first element
                delete new_node;
                is.setstate(std::ios::failbit);
            }

            return is;
        }
    };
}   // namespace sax

#endif // LINKED_LIST_H