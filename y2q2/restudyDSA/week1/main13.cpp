#include <iostream>
#include <string>
#include <vector>

struct Node {
    std::string key;
    int value;
    Node* next;
};

struct HashTable {
    std::vector<Node*> buckets;

    HashTable(size_t size) {
        buckets.resize(size, nullptr);
    }

    // Helper to get index (from your previous code)
    size_t hash(std::string key) {
        size_t hash_value = 0;
        for (char c : key) hash_value += c;
        return hash_value % buckets.size();
    }

    void insert(std::string key, int value) {
        // 1. Calculate the index
        size_t index = hash(key);

        // 2. Create the new node
        Node* new_node = new Node;
        new_node->key = key;
        new_node->value = value;
        new_node->next = nullptr;

        // 3. TODO: Insert 'new_node' into 'buckets[index]'
        // Hint: This is just like "push_front" on a linked list!
        // The "head" of the list is buckets[index].
        new_node->next = buckets[index];
        // Point new_node->next to the current head
        // Update the head (buckets[index]) to be the new_nod
        buckets[index] = new_node;

    }
};

int main() {
    HashTable myTable(10);
    
    // "A" (ASCII 65) -> Index 5
    myTable.insert("A", 100);
    
    // "K" (ASCII 75) -> Index 5 (Collision!)
    myTable.insert("K", 200);

    // If collision handling works, bucket 5 should have both nodes
    Node* current = myTable.buckets[5];
    while (current != nullptr) {
        std::cout << "Key: " << current->key << ", Value: " << current->value << std::endl;
        current = current->next;
    }
    // Expected Output: 
    // Key: K, Value: 200
    // Key: A, Value: 100
    return 0;
}