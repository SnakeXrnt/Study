#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include <algorithm>
#include "utils.h"

bool dfs(int node, 
         const std::unordered_map<int, std::vector<int>>& adj,
         std::unordered_set<int>& visited,
         std::unordered_set<int>& rec_stack,
         std::vector<int>& path,
         std::vector<std::pair<int, int>>& cycle) {
    
    visited.insert(node);
    rec_stack.insert(node);
    path.push_back(node);
    
    if (adj.find(node) != adj.end()) {
        for (int neighbor : adj.at(node)) {
            if (rec_stack.count(neighbor)) {
                // Found cycle
                auto it = std::find(path.begin(), path.end(), neighbor);
                for (auto curr = it; curr != path.end() - 1; curr++) {
                    cycle.push_back({*curr, *(curr + 1)});
                }
                cycle.push_back({path.back(), neighbor});
                return true;
            }
            if (!visited.count(neighbor)) {
                if (dfs(neighbor, adj, visited, rec_stack, path, cycle)) {
                    return true;
                }
            }
        }
    }
    
    rec_stack.erase(node);
    path.pop_back();
    return false;
}

int main() {
    std::vector<std::pair<int, int>> edges;
    std::cin >> edges;
    
    std::unordered_map<int, std::vector<int>> adj;
    std::unordered_set<int> nodes;
    
    for (const auto& [u, v] : edges) {
        adj[u].push_back(v);
        nodes.insert(u);
        nodes.insert(v);
    }
    
    std::unordered_set<int> visited;
    std::unordered_set<int> rec_stack;
    std::vector<std::pair<int, int>> cycle;
    std::vector<int> path;
    
    for (int node : nodes) {
        if (!visited.count(node)) {
            if (dfs(node, adj, visited, rec_stack, path, cycle)) {
                std::cout << cycle << std::endl;
                return 0;
            }
        }
    }
    
    std::cout << "[]" << std::endl;
    return 0;
}
