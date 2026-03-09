#ifndef INCLUDED_BUILDERS_ILOGGER_BUILDER_HPP
#define INCLUDED_BUILDERS_ILOGGER_BUILDER_HPP

#include <string_view>
#include <memory>
#include "ilogger.hpp"

/* the easiest way out of unwanted dependency is below, it's also an accepted practice in C++
 * we work with a pointer so there's no issue just letting clients know that such a class exists
 * it's layout is irrelevant
 *
 * Alternatively, one could create another abstract builder class that inherits from ilogger_builder (ilogger_builder_with_writers :D)
 * and extend it with this one function.
*/

namespace io{
    struct itext_writer;
}

namespace builders {

    class ilogger_builder {
    public:

        virtual ilogger_builder& reset() = 0;

        virtual ilogger_builder& with_console_output() = 0;
        virtual ilogger_builder& with_file_output(std::string_view file_name) = 0;
        virtual ilogger_builder& with_runningtime_timestamp() = 0;

        virtual std::unique_ptr<logging::ilogger> get() = 0;

        virtual ~ilogger_builder() = default;

    };
}


#endif //INCLUDED_BUILDERS_ILOGGER_BUILDER_HPP
