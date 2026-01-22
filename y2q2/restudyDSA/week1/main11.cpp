#include <iostream>
#include <string>

// A simple hash function
size_t get_bucket_index(std::string key, size_t table_size) {
    size_t hash_value = 0;
    
    // 1. TODO: Loop through the string 'key'
    // Add each character (cast to int) to 'hash_value'
    // Example: 'A' is 65, 'B' is 66...

    for (int i = 0; i < key.size(); i++) {
        hash_value += int(key[i]);
    }
    
    // 2. TODO: Fit it into the table

    int final_hash_value = hash_value % table_size;
    // Return hash_value % table_size
    return final_hash_value; // Change this
}

int main() {
    size_t size = 10;
    
    // 'A' is 65. So "A" should be index 5 (65 % 10)
    std::cout << "Index for 'A': " << get_bucket_index("A", size) << std::endl;
    
    // 'A' (65) + 'B' (66) = 131. Index should be 1 (131 % 10)
    std::cout << "Index for 'AB': " << get_bucket_index("AB", size) << std::endl;
    
    return 0;
}