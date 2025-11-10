#ifndef UTILS_H
#define UTILS_H

#include <vector>
#include <list>
#include <forward_list>
#include <iostream>
#include <sstream>

/***
 * Input and output operators for pairs, vectors and forward_lists of any type T that
 * itself supports input and output operators.
**/

template<typename T>
std::istream& operator>>(std::istream& in, std::pair<T, T>& p);

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::pair<T, T>& p);

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
std::istream& operator>>(std::istream& in, std::pair<T, T>& p) {
    char sep1;
    if (!(in >> sep1) || sep1 != '(') throw std::runtime_error("expected opening parenthesis (");
    // read until closing comma
    std::string contents;
    if (!std::getline(in >> std::ws, contents, ')')) throw std::runtime_error("expected closing parenthesis )");
    if (in.unget().get() != ')') throw std::runtime_error("expected closing parenthesis )");

    std::istringstream pair_stream{contents};
    std::string dummy;
    // read first value, then comma, then second value
    std::getline(pair_stream >> std::ws, dummy, ',');
    if (!pair_stream || pair_stream.unget().get() != ',') throw std::runtime_error("expected comma ,");

    std::stringstream value_stream{dummy};
    if (!(value_stream >> p.first)) throw std::runtime_error("expected first value of pair");

    if (!(pair_stream >> std::ws >> p.second)) throw std::runtime_error("expected second value of pair");
    return in;
}

template<typename T>
std::ostream& operator<<(std::ostream& out, const std::pair<T, T>& p) {
    out << "(" << p.first << ", " << p.second << ")";
    return out;
}

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

    // insert spaces before commas to make parsing easier
    size_t pos = line.find(',');
    while (pos != std::string::npos) {
        line.insert(pos, " ");
        pos = line.find(',', pos + 2);
    }

    std::istringstream line_stream{line};
    while (line_stream >> std::ws >> value) {
        vec.push_back(value);
        if (!(line_stream >> std::ws >> sep) || sep != ',') break;
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