#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>
#include <climits> // For INT_MAX

using Graph = std::unordered_map<int, std::vector<std::pair<int, int>>>;

void dijkstra(Graph& g, int start_node) {
    // Map to store the shortest known distance to every node
    std::unordered_map<int, int> distances;
    
    // Set all distances to "Infinity" initially (INT_MAX)
    // We can simulate this by checking if the key exists in the map later.

    // Priority Queue: Stores {Current Distance, Node ID}
    // "greater" ensures the Smallest Distance is at the top.
    std::priority_queue<std::pair<int, int>, 
                        std::vector<std::pair<int, int>>, 
                        std::greater<std::pair<int, int>>> pq;

    // Initialize start
    distances[start_node] = 0;
    pq.push({0, start_node});

    while (!pq.empty()) {
        int current_dist = pq.top().first;
        int current_node = pq.top().second;
        pq.pop();

        // Optimization: If we found a shorter way to this node already, skip.
        if (distances.count(current_node) && current_dist > distances[current_node]) {
            continue;
        }

        // Check all neighbors
        for (auto& edge : g[current_node]) {
            int neighbor = edge.first;
            int weight = edge.second;
            
            // 1. Calculate potential new distance
            int new_dist = current_dist + weight;

            // 2. TODO: If 'new_dist' is smaller than the old known distance...
            // (Note: If distances.count(neighbor) is 0, it means distance is Infinity)
            if (!distances.count(neighbor) || new_dist < distances[neighbor]) {
                 // Update the map
                 distances[neighbor] = new_dist;
                 // Push to PQ
                 pq.push({new_dist,neighbor});
            }
        }
    }

    // Print results
    for (auto& pair : distances) {
        std::cout << "Node " << pair.first << ": " << pair.second << "\n";
    }
}

int main() {
    Graph g;
    // 0 -> 1 (Cost 10)
    // 0 -> 2 (Cost 50)
    // 1 -> 2 (Cost 10) -- Shortest path to 2 should be 0->1->2 (Cost 20), not 0->2 (Cost 50)
    g[0].push_back({1, 10}); g[1].push_back({0, 10});
    g[0].push_back({2, 50}); g[2].push_back({0, 50});
    g[1].push_back({2, 10}); g[2].push_back({1, 10});

    dijkstra(g, 0);
    return 0;
}