#include <iostream>

struct Node {
    int value;
    Node* next;
};

int sum_list(Node* head) {
    // 1. TODO: Base Case (If the list is empty, what is the sum?)

    if(head == nullptr) {
        return 0;
    }
    
    // 2. TODO: Recursive Step (My value + sum of the rest)
    // Hint: Call sum_list on head->next
    int result = head->value + sum_list(head->next);
    return result;
}

int main() {
    // Manual setup: 10 -> 20 -> 30
    Node n3 = {30, nullptr};
    Node n2 = {20, &n3};
    Node n1 = {10, &n2};
    
    std::cout << "Sum should be 60: " << sum_list(&n1) << std::endl;
    return 0;
}