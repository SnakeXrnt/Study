#ifndef UTILS_H
#define UTILS_H

#include <vector>
#include <iostream>

inline std::istream& operator>>(std::istream& in, std::vector<int>& vec) {
    vec.clear();
    int value;      // current value being read
    char sep;   // comma between values
    if (!(in >> sep)) throw std::runtime_error("expected opening bracket [");
    if (sep != '[') throw std::runtime_error("expected opening bracket [");

    if (in >> value) {
        vec.push_back(value);

        // read a comma
        if (!(in >> sep)) throw std::runtime_error("expected comma or closing bracket");
        else if (sep != ',' && sep != ']') throw std::runtime_error("expected closing bracket or comma");
        else if (sep == ']') return in; // done

        // read more values
        while (in >> value) {
            vec.push_back(value);
            if (!(in >> sep)) throw std::runtime_error("expected closing bracket or comma");
            if (sep != ',' && sep != ']') throw std::runtime_error("expected closing bracket or comma");
            if (sep == ']') break;
        }
        if (sep != ']') throw std::runtime_error("expected closing bracket ]");
    }
    else {
        in.clear(); // clear fail state
        // failed to read the first number - must be a closing bracket ]
        if (!(in >> sep)) throw std::runtime_error("expected closing bracket ]");
        if (sep != ']') throw std::runtime_error("expected closing bracket ]");
    }

    return in;
}

inline std::ostream& operator<<(std::ostream& out, const std::vector<int>& vec) {
    out << "[";
    for (size_t i = 0; i < vec.size(); ++i) {
        out << vec[i];
        if (i < vec.size() - 1) out << ", ";
    }
    out << "]";
    return out;
}

#endif // UTILS_H