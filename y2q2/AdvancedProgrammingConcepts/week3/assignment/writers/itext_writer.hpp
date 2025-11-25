#pragma once
#include <string_view>

struct itext_writer {
    virtual itext_writer& operator<<(std::string_view) = 0;
    virtual itext_writer& operator<<(const char*) = 0;
    virtual itext_writer& operator<<(char) = 0;
    virtual itext_writer& operator<<(int) = 0;
    virtual itext_writer& operator<<(double) = 0;

    virtual ~itext_writer() = default;
    
};
