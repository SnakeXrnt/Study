#include "decorators/observable_decorator.hpp"

namespace extensions 
{
    void observable_decorator::log(std::string_view msg) const 
    {
        m_observable.notify_all( {logging::severity::UNKNOWN, msg, this} );
        decorator::log(msg);
    }

    void observable_decorator::log(logging::severity sev, std::string_view msg) const {
        m_observable.notify_all({sev, msg, this});
        decorator::log(sev, msg);
    }

    bool observable_decorator::add_observer(observers::iobserver<logging::log_event>* observer) {
       return m_observable.add_observer(observer);
    }

    bool observable_decorator::remove_observer(observers::iobserver<logging::log_event>* observer) {
        return m_observable.remove_observer(observer);
    }
}