#ifndef COORDINATE_H
#define COORDINATE_H

#include <iostream>
#include <cmath> // for std::sqrt

namespace sax {

    struct coordinate {
        double x{}, y{}, z{};

        double distance_to(const coordinate& b) const {
            double dx = x - b.x;
            double dy = y - b.y;
            double dz = z - b.z;
            return std::sqrt(dx * dx + dy * dy + dz * dz);
        }
    };

    // function for reading a coordinate from an input stream
    // format: (x, y, z)
    std::istream& operator>>(std::istream& in, coordinate& c) {
        char sep;
        if (!(in >> sep) || sep != '(') throw std::runtime_error("expected opening parenthesis (");
        if (!(in >> c.x >> sep) || sep != ',') throw std::runtime_error("expected comma ,");
        if (!(in >> c.y >> sep) || sep != ',') throw std::runtime_error("expected comma ,");
        if (!(in >> c.z >> sep) || sep != ')') throw std::runtime_error("expected closing parenthesis )");
        return in;
    }

    // function for writing a coordinate to an output stream
    // format: (x, y, z)
    std::ostream& operator<<(std::ostream& out, const coordinate& c) {
        out << "(" << c.x << ", " << c.y << ", " << c.z << ")";
        return out;
    }
} // namespace sax

#endif // COORDINATE_H