#include "utils.h"
#include <iostream>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>




int count_paths(int current, int end, std::unordered_map<int, std::vector<int>>& graph, std::unordered_set<int>& visited) {
    if (current == end) return 1;

    visited.insert(current);
    int total = 0;

    for (int neighbor : graph[current]) {
        if (visited.find(neighbor) == visited.end()) {
            total += count_paths(neighbor, end, graph, visited);
        }
    }

    visited.erase(current);
    return total;
}




int main() {
  /* TODO:
      Write a program that reads a list of edges representing an *undirected*
     graph from its standard input (given as a comma-separated list between
     square brackets), followed by two integers representing the start and end
     nodes.

      The program must then compute`` and print the number of *different*
     "simple" paths from the start node to the end node. A simple path is a path
     that does not visit any node more than once - in other words, cycles are
     not allowed.
  */

    std::vector<std::pair<int, int>> edges;
    int start, end;

    // Example input: [(0,1),(1,2),(2,0)] 0 2
    std::cin >> edges >> start >> end;

    std::unordered_map<int, std::vector<int>> graph;
    for (auto& e : edges) {
        graph[e.first].push_back(e.second);
        graph[e.second].push_back(e.first);
    }

    std::unordered_set<int> visited;
    int result = count_paths(start, end, graph, visited);

    std::cout << result << std::endl;
    return 0;


    return 0;

}
