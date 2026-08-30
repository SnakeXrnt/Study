#include <iostream>
#include <string>
#include <vector>

struct Node {
    std::string key;
    int value;
    Node* next;
};

struct HashTable {
    // We need an array (or vector) of Node pointers.
    // Let's use a vector so we can size it dynamically.
    std::vector<Node*> buckets; 

    // Constructor to initialize the table with 'size' empty slots
    HashTable(size_t size) {
        // TODO: Resize 'buckets' to 'size'
        buckets.resize(size, nullptr);
        // TODO: Fill it with nullptr (so we know slots are empty)
    }
};

int main() {
    HashTable myTable(10);
    
    if (myTable.buckets.size() == 10 && myTable.buckets[0] == nullptr) {
        std::cout << "Table initialized correctly!" << std::endl;
    }
    return 0;
}