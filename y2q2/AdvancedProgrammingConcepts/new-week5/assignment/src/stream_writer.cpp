#include "stream_writer.hpp"
#include <iostream>
#include <fstream>

namespace io::writers {
    io::itext_writer& stream_writer::operator<<(std::string_view view) {
        if (m_out)
            *m_out << view;
        return *this;
    }

    io::itext_writer& stream_writer::operator<<(const char* string) {
        if (m_out)
            *m_out << string;
        return *this;
    }

    io::itext_writer& stream_writer::operator<<(char c) {
        if (m_out)
            *m_out << c;
        return *this;
    }

    io::itext_writer& stream_writer::operator<<(int n) {
        if (m_out)
            *m_out << n;
        return *this;
    }

    stream_writer::stream_writer(const char* fname) : m_out{std::make_unique<std::ofstream>(fname)} {
    }

    stream_writer::stream_writer(std::unique_ptr<std::ostream> out) : m_out{std::move(out)} {

    }

    io::itext_writer& stream_writer::operator<<(io::flush_t) {
        if (m_out)
            *m_out << std::flush;
        return *this;
    }
}
