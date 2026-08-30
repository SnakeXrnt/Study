#include "../ilogger.hpp" 
#include <algorithm>
#include <memory.h>
#include <memory>
#include <string_view>
#include <utility>

namespace extensions {
    class decorator : public logging::ilogger {
        public: 
            decorator(std::unique_ptr<logging::ilogger> inner) : m_inner(std::move(inner)) {} 

            virtual ~decorator() override = default;

            void log(const std::string_view msg) const override {
                if (m_inner) {
                    m_inner->log(msg);

                }
            }
        private: 
            std::unique_ptr<logging::ilogger> m_inner;
    };
}
