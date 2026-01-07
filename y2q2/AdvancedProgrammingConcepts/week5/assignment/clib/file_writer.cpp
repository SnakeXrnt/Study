#include <cstring>
#include <cstdlib>
#include "file_writer.h"

// this constructor is protected
file_writer::file_writer() : m_file{nullptr} {}


file_writer::file_writer(const char* fname) :
    m_file{std::fopen(fname, "w+")}
{ }


void file_writer::write(const char* string) {
    write(string, m_file);
}

void file_writer::write(char c) {
    write(c, m_file);
}
void file_writer::write(const char* string, std::FILE* file) {
    if (!file)
        return;
    std::fputs(string, file);
}

file_writer::~file_writer() noexcept {
    if (m_file){
        std::fclose(m_file);
        m_file = nullptr;
    }
}

void file_writer::write(char c, std::FILE* file) {
    if (!file) return;

    fputc(c, file);
}

