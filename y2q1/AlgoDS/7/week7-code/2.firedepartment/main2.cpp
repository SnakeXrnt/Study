#include <iostream>
#include "utils.h"   // for reading vectors
#include "edge.h" 
#include <bits/stdc++.h>


int dijkstra(std::unordered_map<char, std::unordered_map<char, int>> &graph, char start) {

    std::unordered_set<char> visited;
    std::unordered_map<char, int> dists;
    for (const auto&[node, _]: graph) {
        dists[node] = INT_MAX;
    }
    dists[start] = 0;

    std::priority_queue<std::pair<int,char>, std::vector<std::pair<int,char>>, std::greater<>> pq;

    pq.push(std::make_pair(0, start));

    while (pq.size()) {
        const auto [dist, node] = pq.top();

        pq.pop();

        if (visited.contains(node)) continue;
        visited.insert(node);

        for (const auto &[neigh, weight] : graph[node]) {
            dists[neigh] = std::min(dists[neigh], dist + weight);
            if (!visited.contains(neigh)) {
                pq.push(std::make_pair(dists[neigh], neigh));
            }
        }

    }

    // std::cout << "From : " << start;


    int sum = 0;
    for (const auto &[node, dist] : dists) {
        // std::cout << node << " : " << dist << std::endl;
        sum += dist;
    }

    return sum;
}

int main() {
    /* TODO:
        A municipality wants to place a fire department in one of its neighborhoods such that the sum of the distances
        from the fire department to all other neighborhoods is minimized.

        Write a program that computes its optimal placement and prints the smallest sum of distances from the fire
        department to all other neighborhoods.

        The program must read a list of edges representing an *undirected* graph from its standard input (given as a
        comma-separated list between square brackets, e.g. `[(A, B, 5),(B, C, 10),(C, D, 2)]`), where each edge `(A, B, w)`
        indicates that there is a road between neighborhoods A and B with length w.

        The program must then compute at which neighborhood the fire department should be placed, and print the neighborhood
        as well as the sum of the distances from that neighborhood to all other neighborhoods (e.g. `B, 15`).

        The time complexity of your solution must be `O(n m log n)`, where `n` is the number of nodes and `m` is the number
        of edges in the graph.
    */

    std::vector<sax::edge<char>> edges;

    try {
        std::cin >> edges;
    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
    }

    std::unordered_map<char, std::unordered_map<char, int>> graph;

    for (const auto & edge : edges) {
        graph [edge.src][edge.dest] = edge.weight;
        graph [edge.dest][edge.src] = edge.weight;
    }

    int min_sum = INT_MAX;
    char min_node;

    for(const auto &[node, _] : graph) {
        int sum = dijkstra(graph, node);

        if (sum < min_sum) {
            min_node = node;
            min_sum = sum;
        }
    }

    std::cout << min_node << ", " << min_sum << std::endl;


    return 0;
}
