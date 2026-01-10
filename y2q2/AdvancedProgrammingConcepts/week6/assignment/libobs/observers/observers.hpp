#ifndef INCLUDED_OBSERVERS_OBSERVERS_HPP
#define INCLUDED_OBSERVERS_OBSERVERS_HPP

#include <unordered_set>

namespace observers
{
    template<typename TEvent>
    struct iobserver {
        virtual void notify(const TEvent& event) noexcept = 0;
        virtual ~iobserver() noexcept = default;

    };

    template<typename TEvent>
    struct iobservable {
        virtual bool add_observer(iobserver<TEvent>* observer) = 0;
        virtual bool remove_observer(iobserver<TEvent>* observer) = 0;
        virtual ~iobservable() noexcept = default;
    };
    
    template<typename TEvent>
    struct default_observable : public iobservable<TEvent> {
        default_observable() = default;

        virtual bool add_observer(iobserver<TEvent> * observer) override {
            auto&& [_, inserted] = observers_.insert(observer);
            return inserted;
        }

        virtual bool remove_observer(iobserver<TEvent> * observer) override {
            return observers_.erase(observer) != 0;
        }

        [[nodiscard]] bool has_observers() const noexcept {
            return !observers_.empty();
        }

        [[nodiscard]] size_t observer_count() const noexcept {
            return observers_.size();
        }

        void notify_all(const TEvent& event) const noexcept {
            for (auto o: observers_){
                o->notify(event);
            }
        }

        std::unordered_set<iobserver<TEvent>*> observers_;
    };

} // namespace observers

#endif /* INCLUDED_OBSERVERS_OBSERVERS_HPP */
