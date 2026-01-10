#ifndef INCLUDED_BUILDERS_LOGGER_BUILDER_HPP
#define INCLUDED_BUILDERS_LOGGER_BUILDER_HPP

#include <string_view>
#include <string>
#include <memory>
#include "builder/ilogger_builder.hpp"
#include "multi_writer.hpp"

namespace builders {

    class logger_builder: public ilogger_builder {
    public:
        logger_builder();

        virtual ilogger_builder& reset() override;
        virtual ilogger_builder& with_console_output() override;
        virtual ilogger_builder& with_console_output(logging::severity min_sev) override;

        virtual ilogger_builder& with_file_output(std::string_view file_name) override;
        virtual ilogger_builder& with_file_output(std::string_view file_name, logging::severity min_sev) override;

        virtual ilogger_builder& with_writer(std::unique_ptr<io::itext_writer> writer) override;
        virtual ilogger_builder& with_writer(std::unique_ptr<io::itext_writer> writer, logging::severity min_sev) override;

        virtual ilogger_builder& with_timestamp(timestamp_type type) override;

        virtual void make_observable() override;

        virtual std::unique_ptr <logging::ilogger> get() override;
        virtual ~logger_builder() override = default;

    private:
        std::string make_unique_id(std::string_view base="writer");    

        io::writers::multi_writer* m_writer;
        std::unique_ptr<logging::ilogger> m_logger;
        
        bool m_decorated{false};
        bool m_observable{false};
        std::size_t m_next_id{42};
    };

    logger_builder default_builder();

}

#endif //INCLUDED_BUILDERS_LOGGER_BUILDER_HPP
