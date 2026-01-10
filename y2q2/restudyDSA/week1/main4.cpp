
#include <iostream>

struct Node {
    int value;
    Node* next;
};

Node* push_front(Node* current_head, int new_value) {
    // 1. Create the new node
    Node* new_node = new Node;
    new_node->value = new_value;

    // 2. TODO: Link new_node to current_head
    new_node->next = current_head;

    
    // 3. TODO: Return the pointer to the new node
    return new_node; // Change this
}


void print_list(Node* head) {
    // TODO: Use a while loop to travel from 'head' to nullptr
    // Hint: current = current->next
    while (head != nullptr) {
        printf("%d, ", head->value);
        head = head->next;
    }
}

Node* push_back(Node* head, int new_value) {
    Node* new_node = new Node;
    new_node->value = new_value;
    new_node->next = nullptr;

    // 1. Handle the Empty List Edge Case
    if (head == nullptr) {
        return new_node; 
    }

    // 2. Traverse to the end
    Node* current = head;
    // TODO: Write a while loop. Stop when 'current' is the LAST node.
    // (Wait, do we loop while current != nullptr or current->next != nullptr?)

    while(current->next != nullptr) {
        current = current->next;
    }

    // 3. Link the end to the new node
    // current->next = ...?

    current->next = new_node;
    

    return head;
}

int main() {
    Node* head = nullptr; 
    head = push_back(head, 10); 
    head = push_back(head, 20);
    head = push_back(head, 30);
    
    print_list(head); 
    // Expected Output: 10, 20, 30
}