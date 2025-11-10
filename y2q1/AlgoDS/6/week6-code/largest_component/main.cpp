#include <iostream>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>
#include "utils.h"

int main()
{
    /* TODO:
        Write a program that reads a list of edges representing an *undirected* graph
        from its standard input (given as a comma-separated list between square brackets).
        The graph may be disconnected, meaning that there may be multiple connected components.

        The program must then compute and print the size of the largest connected component
        in the graph.

        The time complexity of your solution must be `O(n + m)`, where `n` is the number of nodes
        and `m` is the number of edges in the graph.
    */

    std::vector<std::pair<int, int>> edges;
    std::cin >> edges;

    std::unordered_map<int, std::vector<int>> graph;
    std::unordered_set<int> nodes;

    for (auto& e: edges) {
        graph[e.first].push_back(e.second);
        graph[e.second].push_back(e.first);

        nodes.insert(e.first);
        nodes.insert(e.second);

    }

    std::unordered_set<int> visited;
    int largest = 0;
    
    for (int node : nodes) {
        if (visited.find(node) != visited.end()) continue;
        int size = 0;

        std::queue<int> q;
        q.push(node);
        visited.insert(node);

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            size++;

            for(int neighbor : graph[current]) {
                if (visited.find(neighbor) == visited.end()) {
                    visited.insert(neighbor);
                    q.push(neighbor);
                }
            }
        }

        if (size > largest) largest = size;
    }

    std::cout << largest << std::endl;

    return 0;
}
