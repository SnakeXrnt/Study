#include "file_writer_adapter.hpp"

io::itext_writer& io::writers::file_writer_adapter::operator<<(std::string_view view) {
    // if the view contains a null terminator at the right position then:
    if (*view.cend() == '\0'){
        m_wrt.write(view.data());
    } else{
        // otherwise, iterate over the range
        auto iter{view.cbegin()};
        while(iter != view.cend()){
            m_wrt.write(*iter++);
        }
    }
    return *this;
}

io::itext_writer& io::writers::file_writer_adapter::operator<<(const char* string) {
    m_wrt.write(string);
    return *this;
}

io::itext_writer& io::writers::file_writer_adapter::operator<<(char c) {
    m_wrt.write(c);
    return *this;}

io::itext_writer& io::writers::file_writer_adapter::operator<<(int n) {
    char buffer[16];
    sprintf(&buffer[0], "%d", n);
    m_wrt.write(&buffer[0]);
    return *this;
}

io::itext_writer& io::writers::file_writer_adapter::operator<<(io::flush_t) {
    return *this;
}

io::writers::file_writer_adapter::file_writer_adapter(const char* fname): m_wrt{fname}{}

