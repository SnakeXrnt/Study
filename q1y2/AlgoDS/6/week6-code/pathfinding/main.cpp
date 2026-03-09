#include <iostream>
#include <unordered_map>
#include <queue>
#include <unordered_set>
#include <vector>
#include <algorithm>
#include "utils.h"   // for reading vectors and pairs

// BFS that returns the path from start to target as a vector of chars
std::vector<char> bfs_path(const std::unordered_map<char, std::vector<char>>& adj, char start, char target) {
    if (adj.find(start) == adj.end() || adj.find(target) == adj.end()) return {};

    std::queue<char> q;
    std::unordered_set<char> visited;
    std::unordered_map<char, char> parent;

    visited.insert(start);
    q.push(start);

    bool found = false;
    while (!q.empty() && !found) {
        char cur = q.front(); q.pop();
        auto it = adj.find(cur);
        if (it == adj.end()) continue;
        for (char nei : it->second) {
            if (!visited.count(nei)) {
                visited.insert(nei);
                parent[nei] = cur;
                if (nei == target) { found = true; break; }
                q.push(nei);
            }
        }
    }

    if (!found) return {};

    // reconstruct path
    std::vector<char> path;
    for (char v = target; ; v = parent[v]) {
        path.push_back(v);
        if (v == start) break;
    }
    std::reverse(path.begin(), path.end());
    return path;
}

int main() {
    // Read edges as pairs of char, then start and end as char
    std::vector<std::pair<char, char>> edges;
    char start, end;
    if (!(std::cin >> edges >> start >> end)) {
        std::cerr << "Error reading input" << std::endl;
        return 1;
    }

    std::unordered_map<char, std::vector<char>> graph;
    for (const auto& e : edges) {
        graph[e.first].push_back(e.second);
        graph[e.second].push_back(e.first); // undirected
    }

    auto path = bfs_path(graph, start, end);
    if (path.empty()) {
        std::cout << "[]";
        return 0;
    }

    // print as list of edges: [(A, B), (B, C)]
    std::cout << "[";
    for (size_t i = 0; i + 1 < path.size(); ++i) {
        std::cout << "(" << path[i] << ", " << path[i+1] << ")";
        if (i + 2 < path.size()) std::cout << ", ";
    }
    std::cout << "]";
    return 0;
}
