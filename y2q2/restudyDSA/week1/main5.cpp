#include <iostream>

struct Node {
    int value;
    Node* next;
    Node* prev;
};

// A helper to make new nodes easily
Node* create_node(int val) {
    Node* n = new Node;
    n->value = val;
    n->next = nullptr;
    n->prev = nullptr;
    return n;
}

void delete_node(Node* target) {
    if (target == nullptr) return;

    // 1. Identify the neighbors
    Node* neighbor_before = target->prev;
    Node* neighbor_after = target->next;

    // 2. TODO: If there is a neighbor BEFORE, update its 'next' pointer
    // to skip over 'target'.

    if(neighbor_before != nullptr) {
        neighbor_before->next = neighbor_after;
    }
    
    // 3. TODO: If there is a neighbor AFTER, update its 'prev' pointer
    // to skip over 'target'.
    if (neighbor_after != nullptr) {
        neighbor_after->prev = neighbor_before;
    }

    // 4. Clean up memory
    delete target;
}

int main() {
    // Let's manually build a list: 10 <-> 20 <-> 30
    Node* n1 = create_node(10);
    Node* n2 = create_node(20);
    Node* n3 = create_node(30);

    // Link them up
    n1->next = n2; n2->prev = n1;
    n2->next = n3; n3->prev = n2;

    // Delete the middle one (20)
    delete_node(n2); 

    // Verification:
    // n1->next should be n3
    // n3->prev should be n1
    if (n1->next == n3 && n3->prev == n1) {
        std::cout << "Success! List is now 10 <-> 30" << std::endl;
    } else {
        std::cout << "Something is broken." << std::endl;
    }
    
    return 0;
}