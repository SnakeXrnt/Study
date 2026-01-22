// main.cpp
#include <bits/stdc++.h>
#include "utils.h"     // brings in operator>>/<< for vectors and sax::edge
#include "edge.h"      // sax::edge<T>

bool dfs(std::unordered_map<char, std::unordered_map<char, int>> & graph, std::unordered_map<char, int> & visited_state, std::vector<char> & topo_order, char start) {

    visited_state[start] = 1;

    for (const auto & [neigh, _] : graph[start]) {
        if (visited_state[neigh] == 0) {
            if (dfs(graph, visited_state, topo_order, neigh)) {
                return true;
            }
        } else if (visited_state[neigh] == 1) {
            return true;
        }
    }

    visited_state[start] = 2;
    topo_order.push_back(start);
    return false;
}

int path_len(std::unordered_map<char, std::unordered_map<char, int>> & graph, std::vector<char> & topo_order, char start,char end) {

    std::unordered_map<char,int> lens;
    for (const auto &[node, _] : graph) {
        lens[node] = INT_MAX;
    }
    lens[start] = 0;
    int curr_len = 0;

    for (auto it = topo_order.begin() ; it != topo_order.end() ; it++) {
        const auto curr_node = *it;
        curr_len = lens[curr_node];
        if (curr_node == end)  return lens[end];

        for (const auto &[neigh,weight] : graph[curr_node]) {
            lens[neigh] = std::min(lens[neigh], curr_len + weight);

        }
    }
    return 0;
}

int main() {

    std::vector<sax::edge<char>> edges;

    try {
        std::cin >> edges;
    } catch (const std::exception &e) {
        std::cerr << e.what() << std::endl;
    }

    
    char start, end;
    std::cin >> start >> end;

    // std::cout << edges << std::endl;

    std::unordered_map<char, std::unordered_map<char, int>> graph;

    for (const auto & edge : edges) {
        graph [edge.src][edge.dest] = edge.weight;
    }

    std::vector<char> topo_order;
    std::unordered_map<char, int> visited_state;

    if (dfs(graph, visited_state, topo_order, start)) {
        std::cout << "NO PATH \n" << std::endl;
        return 0;
    }

    std::reverse(topo_order.begin(), topo_order.end());
    std::cout << topo_order << std::endl;

    std::cout << path_len( graph,topo_order, start,end) << std::endl;



    return 0;

}

