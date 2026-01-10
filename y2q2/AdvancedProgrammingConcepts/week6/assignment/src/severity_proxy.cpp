#include "severity_proxy.hpp"

namespace io::writers
{
    severity_proxy::severity_proxy(std::unique_ptr<itext_writer> writer, logging::severity min_sev) noexcept
        : accepting_{false}
        , min_sev_{min_sev}
        , writer_{std::move(writer)}
    {}

    itext_writer& severity_proxy::operator<<(logging::severity sev) {        
        if ( (accepting_ = sev >= min_sev_) ) {
            *writer_ << logging::to_string(sev);
        }
        return *this;
    }

    itext_writer& severity_proxy::operator<<(std::string_view view) {
        if ( check_severity(view) ) {
            *writer_ << view;
        }
        return *this;
    }

    itext_writer& severity_proxy::operator<<(const char* string) {
        if ( check_severity(string) ) {
            *writer_ << string;
        }
        return *this;
    }

    itext_writer& severity_proxy::operator<<(char c) {
        if (accepting())
            *writer_ << c;
        return *this;
    }

    itext_writer& severity_proxy::operator<<(int n) {
        if (accepting())
            *writer_ << n;
        return *this;
    }

    itext_writer& severity_proxy::operator<<(flush_t) {
        *writer_ << io::flush;
        return *this;
    }

    bool severity_proxy::check_severity(std::string_view str) noexcept {

        for (auto&& sev : logging::severities())
        {
            if (str.contains(logging::to_string(sev))) {
                accepting_ = sev >= min_sev_;
                break;
            }
        }
        return accepting_;
    }

    bool severity_proxy::accepting() const noexcept {
        return accepting_;
    }
}