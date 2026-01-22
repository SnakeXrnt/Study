#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>
#include <unordered_set> // To keep track of visited nodes

using Graph = std::unordered_map<int, std::vector<int>>;

void bfs(Graph& g, int start_node) {
    std::queue<int> q;
    std::unordered_set<int> visited;

    // 1. Setup the start
    q.push(start_node);
    visited.insert(start_node);

    std::cout << "BFS Traversal: ";

    // 2. Loop while the queue is not empty
    while (!q.empty()) {
        // TODO: Get the front element and remove it
        int current = q.front();
        q.pop();
        
        std::cout << current << " ";

        // TODO: Visit all neighbors of 'current'
        // Hint: Use a "range-based for loop": for (int neighbor : g[current])
        for(int neighbor : g[current]) {
            if(visited.count(neighbor) == 0) {
                visited.insert(neighbor);
                q.push(neighbor);
            }
        }
        // Only add them to the queue if they are NOT in 'visited'
    }
    std::cout << std::endl;
}

// (Helper add_edge function from before)
void add_edge(Graph& g, int u, int v) {
    g[u].push_back(v);
    g[v].push_back(u);
}

int main() {
    Graph myGraph;
    add_edge(myGraph, 0, 1);
    add_edge(myGraph, 0, 2);
    add_edge(myGraph, 1, 2);
    add_edge(myGraph, 2, 3); // Added a new node 3 connected to 2

    bfs(myGraph, 0);
    // Expected Output: 0 1 2 3 (Order of 1 and 2 might vary)
    return 0;
}