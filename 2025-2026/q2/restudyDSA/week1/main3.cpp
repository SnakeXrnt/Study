
#include <iostream>

struct Node {
    int value;
    Node* next;
};

void print_list(Node* head) {
    // TODO: Use a while loop to travel from 'head' to nullptr
    // Hint: current = current->next
    while (head != nullptr) {
        printf("%d, ", head->value);
        head = head->next;
    }
}

int main() {
    // 1. Create nodes
    Node n1, n2, n3;
    
    // 2. Assign values
    n1.value = 10;
    n2.value = 20;
    n3.value = 30;

    // 3. TODO: Link them up!
    // n1.next = ...?

    n1.next = &n2;
    n2.next = &n3;
    n3.next = nullptr;


    // 4. Print
    print_list(&n1); // Pass the address of the first node

    return 0;
}