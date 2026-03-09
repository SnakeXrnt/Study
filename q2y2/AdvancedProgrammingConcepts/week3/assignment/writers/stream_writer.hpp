
#pragma once
#include "itext_writer.hpp"
#include <fstream>
#include <string>
#include <string_view>

namespace writers {
    class stream_writer : public itext_writer {
        public : 
            explicit stream_writer(const std::string& filename) : m_out{filename} {}

            itext_writer& operator<<(std::string_view text) override {
                m_out << text;
                return *this;
            }

            itext_writer& operator<<(const char* c) override {
                m_out << c;
                return *this;
            }

            itext_writer& operator<<(char c) override {
                m_out << c;
                return *this;
            }

            itext_writer& operator<<(int c) override {
                m_out << c;
                return *this;
            }

            itext_writer& operator<<(double c) override {
                m_out << c;
                return *this;
            }


        private:
            std::ofstream m_out;


    };
}
