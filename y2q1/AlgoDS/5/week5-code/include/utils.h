#ifndef UTILS_H
#define UTILS_H

#include <vector>
#include <list>
#include <forward_list>
#include <iostream>
#include <sstream>

/***
 * Input and output operators for vectors and forward_lists of any type T that
 * itself supports input and output operators.
**/

template<typename T>
std::istream& operator>>(std::istream& in, std::vector<T>& vec);

template<typename T>
std::istream& operator>>(std::istream& in, std::forward_list<T>& lst);

template<typename T>
std::istream& operator>>(std::istream& in, std::list<T>& lst);

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::forward_list<T>& lst);

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::list<T>& lst);

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::vector<T>& vec);

template<typename T>
std::istream& operator>>(std::istream& in, std::vector<T>& vec) {
    vec.clear();
    std::string line, entry;
    T value;      // current value being read
    char sep;   // comma between values
    if (!(in >> sep) || sep != '[') throw std::runtime_error("expected opening bracket [");

    // read remainder into stringstream until closing bracket ]
    if (!std::getline(in >> std::ws, line, ']')) return in;
    in.unget(); // put back the closing bracket for later consumption
    if (in.get() != ']') throw std::runtime_error("expected closing bracket ]");

    std::istringstream line_stream{line};
    while (std::getline(line_stream >> std::ws, entry, ',')) {
        std::istringstream entry_stream{entry};
        if (!(entry_stream >> value)) throw std::runtime_error("expected value");
        vec.push_back(value);
    }

    return in;
}

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::forward_list<T>& lst) {
    out << "[";
    auto it = lst.begin();
    while (it != lst.end()) {
        out << *it;
        ++it;
        if (it != lst.end()) out << " -> ";
    }
    out << "]";
    return out;
}

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::vector<T>& vec) {
    out << "[";
    for (size_t i = 0; i < vec.size(); ++i) {
        out << vec[i];
        if (i < vec.size() - 1) out << ", ";
    }
    out << "]";
    return out;
}

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::list<T>& lst) {
    out << "[";
    auto it = lst.begin();
    while (it != lst.end()) {
        out << *it;
        ++it;
        if (it != lst.end()) out << " <-> ";
    }
    out << "]";
    return out;
}

#endif // UTILS_H