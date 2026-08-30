#pragma once
#include "itime_source.hpp"
#include <string>
#include <string_view>

class system_time_source : public itime_source {
    public:
        std::string_view timestamp() const override;
};
