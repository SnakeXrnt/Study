#ifndef INCLUDED_BUILDERS_LOGGER_BUILDER_HPP
#define INCLUDED_BUILDERS_LOGGER_BUILDER_HPP

#include <string_view>
#include <memory>
#include "builder/ilogger_builder.hpp"
#include "multi_writer.hpp"

namespace builders {

    class logger_builder: public ilogger_builder {
    public:
        logger_builder();

        virtual ilogger_builder& reset() override;
        virtual ilogger_builder& with_console_output() override;
        virtual ilogger_builder& with_file_output(std::string_view file_name) override;

        virtual ilogger_builder& with_runningtime_timestamp() override;

        virtual std::unique_ptr <logging::ilogger> get() override;
        virtual ~logger_builder() override = default;

    private:
        io::writers::multi_writer* m_writer;
        std::unique_ptr<logging::ilogger> m_logger;
    };

    logger_builder default_builder();

}

#endif //INCLUDED_BUILDERS_LOGGER_BUILDER_HPP
