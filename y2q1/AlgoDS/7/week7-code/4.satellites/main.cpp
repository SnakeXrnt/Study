#include <iostream>
#include "utils.h"
#include "coordinate.h"

int main()
{
    /* TODO:
        A communication network consists of a number of satellites that need to be connected to each other.
        Satellites can be connected directly to each other, or indirectly through other satellites - similar to
        how the internet works.

        Since communication is costly, the network must be designed such that the total cost of connecting all
        satellites is minimized. Also, the network must not contain any cycles, since that would be a waste of
        resources. In other words, there should be just one unique communication path between any two satellites.

        Given (x, y, z) coordinates of satellites, write a program that computes the minimum cost to connect all
        satellites in a communication network, where the cost to connect two satellites is given by the Euclidean
        distance between them.

        The program receives a list of satellites from its standard input (given as a comma-separated list between
        square brackets, e.g. `[(0,0,0),(1,1,1),(2,2,2)]`), where each satellite is represented by its (x, y, z)
        coordinates. Use the `sax::coordinate` type to represent the coordinates of a satellite.

        The program must then compute the minimum cost to connect all satellites in a communication network, and print
        this cost to its standard output with two digits after the decimal point (e.g. `3.41`).
    */
    return 0;
}
