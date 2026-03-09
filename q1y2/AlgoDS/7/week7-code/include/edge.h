#ifndef EDGE_H
#define EDGE_H

namespace sax {

    // very simple weighted edge with integer weights
    // and arbitrary type T for source and destination
    template<typename T>
    struct edge {
        T src{}, dest{};
        int weight{};

        // return a new edge with source and destination swapped
        edge<T> reverse() const {
            return {dest, src, weight};
        }
    };

} // namespace sax


#endif // EDGE_H
