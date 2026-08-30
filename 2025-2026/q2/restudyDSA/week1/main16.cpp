#include <iostream>
#include <vector>
#include <unordered_map>

// Node ID -> List of pairs {Neighbor ID, Weight}
using Graph = std::unordered_map<int, std::vector<std::pair<int, int>>>;

void add_edge(Graph& g, int u, int v, int weight) {
    // 1. Add connection u -> v with weight
    g[u].push_back({v, weight});

    // 2. Add connection v -> u with weight (Undirected)
    // TODO: Write this line
    g[v].push_back({u,weight});
}

int main() {
    Graph g;
    // 0 is connected to 1 with cost 10
    add_edge(g, 0, 1, 10);
    
    // 0 is connected to 2 with cost 50
    add_edge(g, 0, 2, 50);

    // Verify:
    std::cout << "Cost from 0 to 1 is: " << g[0][0].second << std::endl;
    return 0;
}