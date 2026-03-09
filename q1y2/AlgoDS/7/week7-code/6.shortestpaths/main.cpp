#include <iostream>
#include "utils.h"   // for reading vectors

int main() {
    /* TODO:
        Write a program that reads a 2D grid from its standard input, where each cell in the grid contains a
        non-negative integer representing the cost to enter that cell.
        The grid is given as a comma-separated list of lists between square brackets, e.g. `[[1, 3, 1, 9],
        [1, 5, 1, 2], [4, 42, 1, 3]]`, where the first list represents the top row of the grid, the second list
        represents the second row of the grid, and so on. You can assume that the grid is rectangular (i.e. all
        rows have the same length).

        The program must then compute the minimum cost to travel from the top-left cell (0, 0) to the bottom-right
        cell (w-1, h-1), where `w` is the width of the grid and `h` is the height of the grid, and print this cost
        to its standard output.
        You can move from a cell to its adjacent cells (up, down, left, right), but you cannot move diagonally.

        Use Dijkstra's algorithm to solve this problem in `O(m log n)` time, where `n` is the number of nodes
        (i.e. cells in the grid) and `m` is the number of edges (i.e. possible moves between cells). This means
        that you will have to use a priority queue to keep track of the next cell to visit.
    */
    return 0;
}
