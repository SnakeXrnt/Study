#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <queue>
#include "utils.h"

int main() {
    std::vector<std::pair<char, char>> edges;
    std::cin >> edges;
    
    std::unordered_map<char, std::vector<char>> adj;
    std::unordered_map<char, int> in_degree;
    std::unordered_set<char> nodes;
    
    // Build graph and calculate in-degrees
    for (const auto& [u, v] : edges) {
        adj[u].push_back(v);
        nodes.insert(u);
        nodes.insert(v);
        in_degree[v]++;
        if (in_degree.find(u) == in_degree.end()) {
            in_degree[u] = 0;
        }
    }
    
    // Kahn's algorithm with min-heap for lexicographic order
    std::priority_queue<char, std::vector<char>, std::greater<char>> q;
    for (const auto& node : nodes) {
        if (in_degree[node] == 0) {
            q.push(node);
        }
    }
    
    std::vector<char> result;
    while (!q.empty()) {
        char u = q.top();
        q.pop();
        result.push_back(u);
        
        for (char v : adj[u]) {
            in_degree[v]--;
            if (in_degree[v] == 0) {
                q.push(v);
            }
        }
    }
    
    if (result.size() != nodes.size()) {
        //std::cout << "hey pal, there's a big old cycle there" << std::endl;
        std::cout << "CYCLE" << std::endl;
    } else {
        std::cout << result << std::endl;
    }
    
    return 0;
}
