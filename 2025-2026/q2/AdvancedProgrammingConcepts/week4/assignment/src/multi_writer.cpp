#include "multi_writer.hpp"

io::itext_writer& io::writers::multi_writer::operator<<(std::string_view view) {
    for (const auto& [_, w]: m_writers)
        *w << view;
    return *this;
}

io::itext_writer& io::writers::multi_writer::operator<<(const char* string) {
    for (const auto& [_, w]: m_writers)
        *w << string;
    return *this;}

io::itext_writer& io::writers::multi_writer::operator<<(char c) {
    for (const auto& [_, w]: m_writers)
        *w << c;
    return *this;}

io::itext_writer& io::writers::multi_writer::operator<<(int n) {
    for (const auto& [_, w]: m_writers)
        *w << n;
    return *this;}

io::itext_writer& io::writers::multi_writer::operator<<(io::flush_t flush) {
    for (const auto& [_, w]: m_writers)
        *w << flush;
    return *this;}

io::writers::multi_writer::multi_writer(): m_writers{} {}

void io::writers::multi_writer::add_writer(const std::string& name, std::unique_ptr<io::itext_writer> writer) {
    m_writers.emplace(name, std::move(writer));
}

void io::writers::multi_writer::remove_writer(const std::string& name) {
    m_writers.erase(name);
}

