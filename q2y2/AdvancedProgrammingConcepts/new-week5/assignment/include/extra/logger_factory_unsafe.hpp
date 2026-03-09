#ifndef INCLUDED_EXTRA_LOGGER_FACTORY_UNSAFE_HPP
#define INCLUDED_EXTRA_LOGGER_FACTORY_UNSAFE_HPP

#include <memory>
#include "ilogger.hpp"
#include "builder/logger_builder.hpp"

namespace extra {

    /// because of my laziness, and also to make it easier to check your solution,
    /// you are allowed to implement your extra classes in header files!

    // BTW, there is a thread sanitizer in gcc/clang that can help you
    // It's not compatible with ASAN/ UBSAN though, so you will need to disable those if you want to use TSAN.
    // Compile with -fsanitize=thread to enable it.

    class logger_factory_unsafe {
    public:

        static logger_factory_unsafe& get() {
            static logger_factory_unsafe factory;
            return factory;
        }

        logging::ilogger& default_logger()
        {
            if (!m_logger)
            {
                // Logger is lazily created on first use
                m_logger = builders::default_builder()
                    .with_console_output()
                    .get();

                // if you have implemented concurrent_decorator in the previous assignment, you can add it here as well
                // m_logger = std::make_unique<extensions::concurrent_decorator>(std::move(m_logger));
            }
            return *m_logger;
        }
    private:
        std::unique_ptr<logging::ilogger> m_logger;
    };
}

#endif /* INCLUDED_EXTRA_LOGGER_FACTORY_UNSAFE_HPP */
