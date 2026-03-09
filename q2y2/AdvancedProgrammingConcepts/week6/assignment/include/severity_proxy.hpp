#ifndef INCLUDED_IO_SEVERITY_PROXY_HPP
#define INCLUDED_IO_SEVERITY_PROXY_HPP

#include <memory>
#include <string_view>
#include "itext_writer.hpp"
#include "severity.hpp"

namespace io::writers {

class severity_proxy : public itext_writer {
public:
    severity_proxy() noexcept = default;
    severity_proxy(std::unique_ptr<itext_writer> writer, logging::severity min_sev) noexcept;

    virtual itext_writer& operator<<(logging::severity sev);

    itext_writer& operator<<(std::string_view) override;
    itext_writer& operator<<(const char*) override;
    itext_writer& operator<<(char c) override;
    itext_writer& operator<<(int n) override;
    itext_writer& operator<<(flush_t) override;
    
    bool accepting() const noexcept;

    ~severity_proxy() noexcept = default;
private:
    bool check_severity(std::string_view str) noexcept;
    bool accepting_{};
    logging::severity min_sev_{logging::severity::UNKNOWN};
    std::unique_ptr<itext_writer> writer_;
};
}


#endif //INCLUDED_IO_SEVERITY_PROXY_HPP
