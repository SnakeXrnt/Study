#include <iostream>

struct Node {
    int value;
    Node* next;
};

struct Queue {
    Node* head = nullptr;
    Node* tail = nullptr; // Keeps track of the last node!
};

void enqueue(Queue& q, int value) {
    // 1. Create the new node
    Node* new_node = new Node;
    new_node->value = value;
    new_node->next = nullptr;

    // 2. Edge Case: If queue is empty
    if (q.head == nullptr) {
        // Both head and tail point to the new node
        q.head = new_node;
        q.tail = new_node;
        return;
    }

    // 3. Normal Case: Add to the end using 'tail'
    // TODO: Link the current tail to the new node
    // TODO: Update the tail pointer to be the new node
    q.tail->next = new_node;
    q.tail = new_node;



}

int main() {
    Queue myQ;
    enqueue(myQ, 10);
    enqueue(myQ, 20);
    enqueue(myQ, 30);
    
    // Check if tail is correct (should be 30)
    if (myQ.tail->value == 30) std::cout << "Tail is correct!" << std::endl;
    return 0;
}