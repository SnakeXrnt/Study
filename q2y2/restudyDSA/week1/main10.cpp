#include <iostream>

struct TreeNode {
    int value;
    TreeNode* left;
    TreeNode* right;
};

// Helper to create a new node cleanly
TreeNode* create_node(int val) {
    TreeNode* n = new TreeNode;
    n->value = val;
    n->left = nullptr;
    n->right = nullptr;
    return n;
}

void print_tree(TreeNode* node) {
    if (node == nullptr) return;
    print_tree(node->left);
    std::cout << node->value << " ";
    print_tree(node->right);
}

bool contains(TreeNode* root, int target) {
    // 1. Check if empty
    if (root == nullptr) return false;

    // 2. Check if found
    if (root->value == target) return true;

    // 3. Decide which way to go
    if (target < root->value) {
        // Debug print to show us "walking" the tree
        std::cout << "  (Going Left from " << root->value << ")..." << std::endl;
        return contains(root->left, target);
    } else {
        // Debug print to show us "walking" the tree
        std::cout << "  (Going Right from " << root->value << ")..." << std::endl;
        return contains(root->right, target); 
    }
}

int main() {
    // Level 1 (Root)
    TreeNode* root = create_node(10);

    // Level 2
    root->left = create_node(5);
    root->right = create_node(15);

    // Level 3 (Children of 5)
    root->left->left = create_node(2);
    root->left->right = create_node(7);

    // Level 3 (Children of 15)
    root->right->left = create_node(12);
    root->right->right = create_node(20);

    // Test 1: Search for a number deep in the tree (12)
    std::cout << "Searching for 12:" << std::endl;
    if (contains(root, 12)) {
        std::cout << "Found 12!\n" << std::endl;
    } else {
        std::cout << "12 not found.\n" << std::endl;
    }

    // Test 2: Search for a number that DOESN'T exist (99)
    std::cout << "Searching for 99:" << std::endl;
    if (contains(root, 99)) {
        std::cout << "Found 99!\n" << std::endl;
    } else {
        std::cout << "99 not found (Correct).\n" << std::endl;
    }
    
    // Test 3: Print all to prove it's sorted
    std::cout << "Full Tree: ";
    print_tree(root);
    std::cout << std::endl;

    return 0;
}