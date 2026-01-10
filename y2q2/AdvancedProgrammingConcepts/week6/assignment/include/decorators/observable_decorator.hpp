#ifndef INCLUDED_DECORATORS_OBSERVABLE_DECORATOR_HPP
#define INCLUDED_DECORATORS_OBSERVABLE_DECORATOR_HPP

#include "decorator.hpp"
#include "observers/observers.hpp"
#include "logging_event.hpp"

namespace extensions {

    class observable_decorator: public decorator, public observers::iobservable<logging::log_event> {
    public:
        using decorator::decorator;
        
        virtual void log(std::string_view msg) const override;

        virtual void log(logging::severity sev, std::string_view msg) const override;
    
        virtual bool add_observer(observers::iobserver<logging::log_event>* observer) override;

        virtual bool remove_observer(observers::iobserver<logging::log_event>* observer) override;

    private:
        observers::default_observable<logging::log_event> m_observable{};
    };
}

#endif /* INCLUDED_DECORATORS_OBSERVABLE_DECORATOR_HPP */
