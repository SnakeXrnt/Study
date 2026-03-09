// main.cpp
#include <bits/stdc++.h>
#include "utils.h"     // brings in operator>>/<< for vectors and sax::edge
#include "edge.h"      // sax::edge<T>


bool dfs(std::unordered_map<char, std::unordered_map<char,int>> & graphs, std::unordered_map<char, int> & visited, char start , std::vector<char> & topo_order) {

    visited[start] = 1;

    for (const auto &[nodes, weight] : graphs[start]) {
        if (visited[nodes] == 0) {
            if (dfs(graphs, visited, nodes, topo_order)) {
                return true;
            } 
        } else if (visited[nodes] == 1) {
                return true;
        }
    }

    visited[start] = 2;
    topo_order.push_back(start);
    return false;
}



int main() {

   std::vector<sax::edge<char>> edges;

   std::cin >> edges;

   char start, goal;

   std::cin >> start >> goal;

   std::unordered_map<char, std::unordered_map<char,int>> graphs;

   for (const auto edge : edges) {
        graphs[edge.src][edge.dest] = edge.weight;
   }

   std::unordered_map<char, int> visited;
   std::vector<char> topo_order;


   if (dfs(graphs,visited,start,topo_order)) {
    std::cout << "found cycle bitch" << std::endl;
    
   } else {
    std::cout << "no cycle ass" << std::endl;
    std::cout << topo_order << std::endl;
   }


   



}

