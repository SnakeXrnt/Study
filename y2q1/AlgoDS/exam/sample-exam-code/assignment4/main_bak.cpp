
#include <deque>
#include <iostream>
#include <ostream>
#include <unordered_map>
#include <variant>
#include "utils.h"

bool check_cycle(char start, std::vector<std::pair<char, char>>& edges, std::unordered_map<char, int>& visited,std::deque<char> & cycled_nodes ) {
    visited[start] = 1;
    for (const auto& edge : edges) {
        if (edge.first == start) {
            // edge second is my neighbor
            if(visited[edge.second] == 1) {
                // found a cycle, put in cycled_nodes
                cycled_nodes.push_front(edge.second);
                cycled_nodes.push_front(edge.first);
                return true;
            } else if (visited[edge.second] == 0 && check_cycle(edge.second,edges,visited,cycled_nodes)) {
                cycled_nodes.push_front(edge.first);
                return true;
            }
        }
    }
    visited[start] = 2;
    return false;
}

int main() {
    // NOTE: See testing.md for instructions on how to test your solution
    //       PowerShell: Get-Content data\input1.txt | .\assignment4.exe
    //       Command Prompt: assignment1.exe < data\input1.txt
    std::vector<std::pair<char, char>> edges;
    std::cin >> edges;

    if (std::cin.fail()) {
        std::cerr << "Failed to read graph edges from input." << std::endl;
        return 1;
    }

    std::unordered_map<char, int> visited;
    std::deque<char> cycled_nodes;
    bool is_there_cycle = false;

    for (const auto& edge : edges) {
        if(visited[edge.first]){
            continue;
        }

        if (check_cycle(edge.first, edges,visited,cycled_nodes)) {
            is_there_cycle = true;
            break;
        }

    }

    if (!is_there_cycle) {
        std::cout << "there is no cycle detected" << std::endl;
        return 0;
    }

    bool print = false;
    char cycle_boundaries = cycled_nodes.back();

    for(const auto& node :cycled_nodes) {
        if (node == cycle_boundaries && !print) {
            print = true;
        } else if (node == cycle_boundaries) {
            print = false;
        }

        if (print) {
            std::cout << node << " -> " ;
            
        }
    }

    std::cout << cycle_boundaries << std::endl;

    // TODO: Find cycle in the directed graph represented by edges
    
    

    return 0;
}
