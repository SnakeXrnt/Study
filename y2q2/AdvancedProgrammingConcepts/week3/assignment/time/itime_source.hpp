#pragma once
#include <string_view>
#include <memory>

struct itime_source {
    // return a textual timestamp
    // the view must point to a buffer  that stays valid
    // at least until the next call to timestamp
    virtual std::string_view timestamp() const = 0;
    virtual ~itime_source() = default;
};
