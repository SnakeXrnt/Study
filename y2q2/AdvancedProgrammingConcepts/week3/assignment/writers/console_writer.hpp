#pragma once
#include "itext_writer.hpp"
#include <iostream>
#include <string>
#include <string_view>

namespace writers {
    class console_writer : public itext_writer {
        public: 
            itext_writer& operator<<(std::string_view text) override {
                std::cout << text;
                return *this;
            }

            itext_writer& operator<<(const char* text) override {
                std::cout << text;
                return *this;
            }

            itext_writer& operator<<(char c) override {
                std::cout << c;
                return *this;
            }

            itext_writer& operator<<(int c) override {
                std::cout << c;
                return *this;
            }

            itext_writer& operator<<(double c) override {
                std::cout << c;
                return *this;
            }
    };
}
