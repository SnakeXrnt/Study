#include <iostream>
#include <queue>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>
#include "utils.h"   // for reading vectors

int main() {
    /* TODO:
        Write a program that reads a list of edges representing an *undirected* graph
        from its standard input (given as a comma-separated list between square
        brackets, e.g. `[(A, B),(B, C),(C, D)]`), followed by two characters representing
        the start and end nodes.

        The program must then find the path with the fewest edges between the start and
        end nodes, and print the number of edges of that path, or `-1` if no such path exists.
    */

    std::vector<std::pair<char, char>> edges;
    char start;
    char end;

    std::cin >> edges >> start >> end;

    std::unordered_map<char, std::vector<char>> graph;

    for (auto& e: edges) {
        graph[e.first].push_back(e.second);
        graph[e.second].push_back(e.first);
    }

    std::queue<std::pair<char, int>> q;
    std::unordered_set<char> visited;

    q.push({start, 0});
    visited.insert(start);

    while (!q.empty()) {
        auto [node, dist] = q.front();
        q.pop();
        if (node == end) {
            std::cout << dist << std::endl;
            return 0;
        }

        for (auto& neighbor : graph[node]) {
            if (visited.find(neighbor) == visited.end()) {
                visited.insert(neighbor);
                q.push({neighbor, dist + 1});
            }
        }
    }
    std::cout << -1 << std::endl;


    return 0;
}

