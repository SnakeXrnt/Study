#pragma once
#include <string_view>

struct itext_writer {

    //virtual issa tool. just sitting there waiting to be used
    virtual itext_writer& operator<<(std::string_view) = 0;
    virtual itext_writer& operator<<(const char*) = 0;
    virtual itext_writer& operator<<(char) = 0;
    virtual itext_writer& operator<<(int) = 0;
    virtual itext_writer& operator<<(double) = 0;

    // destructor for every itextwriter tool
    virtual ~itext_writer() = default;
    
};
