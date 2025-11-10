#ifndef COUNTER_H
#define COUNTER_H

#include <cstddef>

namespace sax {
    // singleton class to keep track of number of comparisons and/or swaps
    class counter {
    public:
        // get the single instance of the counter class
        static counter& instance();

        // increment the comparisons and swaps counters
        void inc_comparisons();
        void inc_swaps();

        // get the number of comparisons and swaps
        size_t comparisons() const;
        size_t swaps() const;

    private:
        counter() : comparisons_(0), swaps_(0) {}
        size_t comparisons_;
        size_t swaps_;
    };
}

#endif // COUNTER_H
