#include <iostream>
#include <functional>
#include <unordered_map>
#include <climits>
#include "utils.h"

struct Point {
    int x;
    int y;
    

    bool operator==(const Point& other) const {
        return x == other.x && y == other.y;
    }
};

namespace std { // must be in std namespace
    template <>                 // specialization of std::hash for Point
    struct hash<Point> {        // defines std::hash<Point>
        size_t operator()(const Point& p) const {       // the () operator to make it callable (note the const!)
            return hash<int>()(p.x) ^ (hash<int>()(p.y) << 1); // Combine hashes of x and y
        }
    };
}

int main() {
    std::unordered_map<Point, int> visit_count;
    std::unordered_map<Point, int> visit_order;  
    Point coordinates = {0, 0};
    int order_counter = 0;
    
    visit_count[coordinates] = 1;
    visit_order[coordinates] = order_counter++;
    
    char c;
    while (std::cin >> c)
    {
        if (c == 'U')
        {
            coordinates.y++;
        }
        else if (c == 'D')
        {
            coordinates.y--;
        }
        else if (c == 'L')
        {
            coordinates.x--;
        }
        else if (c == 'R')
        {
            coordinates.x++;
        }
        
        if (visit_count.find(coordinates) == visit_count.end()) {
            visit_order[coordinates] = order_counter++;
        }
        visit_count[coordinates]++;
    }
    
    Point top1, top2, top3;
    bool found1 = false, found2 = false, found3 = false;
    
    for (const auto& pair : visit_count) {
        Point point = pair.first;
        int count = pair.second;
        int order = visit_order[point];
        
        if (!found1 || count > visit_count[top1] || 
            (count == visit_count[top1] && order < visit_order[top1])) {
            if (found1) {
                if (found2) {
                    top3 = top2;
                    found3 = true;
                }
                top2 = top1;
                found2 = true;
            }
            top1 = point;
            found1 = true;
        }
        else if (!found2 || count > visit_count[top2] || 
                 (count == visit_count[top2] && order < visit_order[top2])) {
            if (found2) {
                top3 = top2;
                found3 = true;
            }
            top2 = point;
            found2 = true;
        }
        else if (!found3 || count > visit_count[top3] || 
                 (count == visit_count[top3] && order < visit_order[top3])) {
            top3 = point;
            found3 = true;
        }
    }
    
        std::cout << "(" << top1.x << ", " << top1.y << ")";
        std::cout << ", (" << top2.x << ", " << top2.y << ")";
        std::cout << ", (" << top3.x << ", " << top3.y << ")";
    std::cout << std::endl;
    
    /* TODO:
        Write a program that inputs a string consisting of the characters "U", "D", "L", and "R",
        representing movements Up, Down, Left, and Right on a 2D grid, starting from the origin (0, 0).

        The program must then compute and print the top three of *the most visited unique coordinates*
        that are visited during the sequence of movements, including the starting point (0, 0).

        Ties should be broken by the order in which the coordinates were first visited.

        For example, given the input string "UUDLURD", the program must print `(0, 1), (0, 2), (0, 0)`,
        because the visited coordinates are (0, 0), (0, 1), (0, 2), (0, 1), (-1, 1), (-1, 2), (0, 2), and (0, 1).

        The time complexity of your solution must be O(n + 3 log(n)), which can be simplified to O(n + log(n))
        where n is the length of the input string.

        To efficiently store and check for unique coordinates, you should use a hash table (e.g.
        `std::unordered_set` or `std::unordered_map` in C++). Note that you will have to define a custom hash
        function for the coordinate pairs, as well as an equality operator. Also, you must copy the coordinates
        into a vector or similar structure to be able to sort them by their visit counts.

        As a final note, you are not allowed to use the nth_element algorithm from the standard library.
    */
    return 0;
}
