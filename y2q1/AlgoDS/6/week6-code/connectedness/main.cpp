#include <iostream>
#include <unordered_map>
#include <unordered_set>
#include "utils.h"   // for reading vectors

/// @brief Depth-first search to explore the graph, stops when all reachable nodes have been visited
/// @param node The current node being visited
/// @param graph The adjacency list representation of the graph
/// @param visited A set of visited nodes
void dfs(int node, const std::unordered_map<int, std::vector<int>>& graph, std::unordered_set<int>& visited) {
    visited.insert(node);
    for (int neighbor : graph.at(node)) {
        if (!visited.contains(neighbor)) {
            dfs(neighbor, graph, visited);
        }
    }
}

int main() {
    /* TODO:
        Write a program that reads a list of edges representing a *directed* graph from its standard input (given as a comma-separated list between square brackets, e.g. `[(0,1),(1,2),(2,0)]`), followed by two integers representing the start and end nodes.
        The program must then determine whether there exists a path from the start node to the end node.
        If such a path exists, the program must print `YES`, otherwise it must print `NO`.
    */
    std::vector<std::pair<int, int>> edges; // list of edges
    int start, end;
    if (!(std::cin >> edges >> start >> end)) {
        std::cerr << "Error reading input" << std::endl;
        return 1;
    }

    // The graph is represented as an adjacency list using an unordered_map
    // where the keys are the node values and the values are vectors of adjacent nodes.
    std::unordered_map<int, std::vector<int>> graph;

    // Fill the graph from the list of edges
    for (const auto& edge : edges) {
        graph[edge.first].push_back(edge.second);
        graph[edge.second]; // ensure the second node is also in the graph
    }

    // Perform a recursive DFS to find if there's a path from start to end
    std::unordered_set<int> visited;
    dfs(start, graph, visited);

    // Check if the end node was reached
    if (visited.contains(end)) std::cout << "YES" << std::endl;
    else std::cout << "NO" << std::endl;

    return 0;
}
