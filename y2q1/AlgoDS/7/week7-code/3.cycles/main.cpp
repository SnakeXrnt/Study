#include <iostream>
#include <unordered_map>
#include "utils.h"

struct DSU {
    std::unordered_map<char, char> boss;

    char find(char person) {
        if (boss.find(person) == boss.end()) {
            boss[person] = person;
        }

        if (boss[person] == person) {
            return person;
        }

        boss[person] = find(boss[person]);
        return boss[person];
    }

    void unite(char persona, char personb) {
        char leadera = find(persona);
        char leaderb = find(personb);

        if (leadera != leaderb) {
            boss[leadera] = leaderb;
        }
    }
};

int main() {

    std::vector<sax::edge<char>> edges;
    std::cin >> edges;
    DSU networkmanager;
    

    int safe_merge_count = 0;

    for (const auto &[nodeb, nodea, weights] : edges) {
        char leadera = networkmanager.find(nodea);
        char leaderb = networkmanager.find(nodeb);

        if (leadera == leaderb ) {
            break;
        } else {
            networkmanager.unite(leadera, leaderb);
            safe_merge_count++;
        }

    }

    std::cout << safe_merge_count << std::endl;
    
    return 0;
}
