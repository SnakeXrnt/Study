#include <iostream>
#include <vector>
#include <unordered_map>

// The Graph Data Structure
// Key: Node ID (int)
// Value: List of neighbors (vector<int>)
using Graph = std::unordered_map<int, std::vector<int>>;

void add_edge(Graph& g, int u, int v) {
    // 1. TODO: Add 'v' to 'u's neighbor list
    // Hint: g[u] gives you the vector for node u. Push back v!
    
    g[u].push_back(v);

    // 2. TODO: Add 'u' to 'v's neighbor list (because it's undirected!)

    g[v].push_back(u);
}

int main() {
    Graph myGraph;

    // Build the triangle: 0-1, 0-2, 1-2
    add_edge(myGraph, 0, 1);
    add_edge(myGraph, 0, 2);
    add_edge(myGraph, 1, 2);

    // Verify neighbors of 0
    std::cout << "Neighbors of 0: ";
    for (int neighbor : myGraph[0]) {
        std::cout << neighbor << " ";
    }
    // Expected: 1 2 (or 2 1)
    
    return 0;
}