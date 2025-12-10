#ifndef INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP
#define INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP

#include <string>
#include <memory>
#include "ilogger.hpp"

namespace extensions {

class timestamp_decorator: public logging::ilogger {
public:
    explicit timestamp_decorator(std::unique_ptr<logging::ilogger> inner) noexcept;
    virtual void log(std::string_view msg) const override;
private:
    std::unique_ptr<logging::ilogger> m_inner;
};
}

#endif //INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP
