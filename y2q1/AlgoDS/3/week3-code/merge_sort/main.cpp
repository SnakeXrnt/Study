#include <iostream>
#include <string>
#include <fstream>  // for std::ifstream, std::ofstream
#include "counter.h" // for sax::counter
#include "linked_list.h"
sax::linked_list_node<std::string>* split(sax::linked_list_node<std::string> *head);
sax::linked_list_node<std::string>* merge_sort(sax::linked_list_node<std::string> *head);
sax::linked_list_node<std::string>* merge(sax::linked_list_node<std::string> *left, sax::linked_list_node<std::string> *right);
int main() {
    std::string input_file, output_file;
    
    std::cout << "Enter input file name: ";
    std::cin >> input_file;
    std::cout << "Enter output file name: ";
    std::cin >> output_file;
    
    std::ifstream infile(input_file);
    if (!infile.is_open()) {
        std::cerr << "Error: Could not open input file " << input_file << std::endl;
        return 1;
    }
    
    sax::linked_list_node<std::string>* head = nullptr;
    sax::linked_list_node<std::string>* tail = nullptr;
    std::string line;
    
    while (std::getline(infile, line)) {
        auto new_node = new sax::linked_list_node<std::string>();
        new_node->data = line;
        new_node->next = nullptr;
        
        if (head == nullptr) {
            head = tail = new_node;
        } else {
            tail->next = new_node;
            tail = new_node;
        }
    }
    infile.close();
    
    sax::counter& counter_instance = sax::counter::instance();
    size_t initial_comparisons = counter_instance.comparisons();
    
    head = merge_sort(head);
    
    size_t comparisons_performed = counter_instance.comparisons() - initial_comparisons;
    
    std::ofstream outfile(output_file);
    if (!outfile.is_open()) {
        std::cerr << "Error: Could not open output file " << output_file << std::endl;
        sax::linked_list_node<std::string>::cleanup(head);
        return 1;
    }
    
    auto current = head;
    while (current != nullptr) {
        outfile << current->data << std::endl;
        current = current->next;
    }
    outfile.close();
    
    std::cout << "Number of comparisons: " << comparisons_performed << std::endl;
    
    sax::linked_list_node<std::string>::cleanup(head);
    
    return 0;
}

sax::linked_list_node<std::string>* merge_sort(sax::linked_list_node<std::string> *head) {
    if (head == nullptr || head->next == nullptr) {
        // Base case: list is empty or has one element
        return head;
    }
    // Step 1: Split the list into two halves
    sax::linked_list_node<std::string> *mid = split(head);
    // Step 2: Recursively sort both halves
    head = merge_sort(head);
    mid = merge_sort(mid);
    // Step 3: Merge the sorted halves
    return merge(head, mid);
}
sax::linked_list_node<std::string>* split(sax::linked_list_node<std::string>* head) {
    if (head == nullptr || head->next == nullptr) {
        return nullptr;
    }
    
    auto slow = head;
    auto fast = head->next;
    
    while (fast != nullptr && fast->next != nullptr) {
        slow = slow->next;
        fast = fast->next->next;
    }
    
    auto middle = slow->next;
    slow->next = nullptr;  // Cut the connection
    
    return middle;
}

sax::linked_list_node<std::string>* merge(sax::linked_list_node<std::string> *left, sax::linked_list_node<std::string> *right) {
    // Create a dummy node to simplify the merge logic
    sax::linked_list_node<std::string> dummy;
    auto current = &dummy;
    
    while (left != nullptr && right != nullptr) {
        // Count the comparison
        sax::counter::instance().inc_comparisons();
        
        if (left->data <= right->data) {
            current->next = left;
            left = left->next;
        } else {
            current->next = right;
            right = right->next;
        }
        current = current->next;
    }
    
    // Attach remaining nodes
    if (left != nullptr) {
        current->next = left;
    } else {
        current->next = right;
    }
    
    return dummy.next;
}


