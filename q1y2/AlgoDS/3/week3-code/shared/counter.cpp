#include "counter.h"

sax::counter& sax::counter::instance() {
    static counter instance;
    return instance;
}

void sax::counter::inc_comparisons() { ++comparisons_; }
void sax::counter::inc_swaps() { ++swaps_; }

size_t sax::counter::comparisons() const { return comparisons_; }
size_t sax::counter::swaps() const { return swaps_; }
