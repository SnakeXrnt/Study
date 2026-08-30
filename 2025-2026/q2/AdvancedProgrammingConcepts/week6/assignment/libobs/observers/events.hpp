#ifndef INCLUDED_OBSERVERS_EVENTS_HPP
#define INCLUDED_OBSERVERS_EVENTS_HPP

#include <functional>
#include <unordered_map>
#include <optional>

#include "observers.hpp"

namespace observers
{
  // Primary template: no friend mechanism (operator() will be public)
  template <typename... Args>
  class event {
  public:
    // Type aliases
    using callback_t = std::function<void(Args...)>;
    using handle_t = std::size_t;
    
    // Subscribe callback (lvalue reference - copy)
    handle_t operator+=(const callback_t& callback) {
      handle_t handle = m_next_handle++;
      m_callbacks[handle] = callback;
      return handle;
    }
    
    // Subscribe callback (rvalue reference - move)
    handle_t operator+=(callback_t&& callback) {
      handle_t handle = m_next_handle++;
      m_callbacks[handle] = std::move(callback);
      return handle;
    }
    
    // Subscribe iobserver (for compatibility with legacy observer pattern)
    template <typename TEvent>
    handle_t operator+=(iobserver<TEvent>* observer) {
      callback_t callback = [observer](Args... args) {
        observer->notify(TEvent{args...});
      };
      return (*this) += std::move(callback);
    }
    
    // Unsubscribe by handle
    bool operator-=(handle_t handle) {
      return m_callbacks.erase(handle) > 0;
    }
    
    // Invoke the event (notify all subscribers)
    void operator()(Args... args) {
      for (auto&& [handle, callback] : m_callbacks) {
        try {
          callback(args...);
        } catch (...) {
          // Catch exceptions to ensure all subscribers are notified
        }
      }
    }
    
  private:
    std::unordered_map<handle_t, callback_t> m_callbacks;
    handle_t m_next_handle = 0;
  };
  
  // Partial specialization: with friend mechanism (operator() is private)
  // First template parameter is the owner class
  template <typename TOwner, typename... Args>
  class event<TOwner, Args...> {
  public:
    // Type aliases
    using callback_t = std::function<void(Args...)>;
    using handle_t = std::size_t;
    
    // Subscribe callback (lvalue reference - copy)
    handle_t operator+=(const callback_t& callback) {
      handle_t handle = m_next_handle++;
      m_callbacks[handle] = callback;
      return handle;
    }
    
    // Subscribe callback (rvalue reference - move)
    handle_t operator+=(callback_t&& callback) {
      handle_t handle = m_next_handle++;
      m_callbacks[handle] = std::move(callback);
      return handle;
    }
    
    // Subscribe iobserver (for compatibility with legacy observer pattern)
    template <typename TEvent>
    handle_t operator+=(iobserver<TEvent>* observer) {
      callback_t callback = [observer](Args... args) {
        observer->notify(TEvent{args...});
      };
      return (*this) += std::move(callback);
    }
    
    // Unsubscribe by handle
    bool operator-=(handle_t handle) {
      return m_callbacks.erase(handle) > 0;
    }
    
  private:
    // Make owner class a friend so it can invoke the event
    friend TOwner;
    
    // Invoke the event (notify all subscribers) - PRIVATE
    void operator()(Args... args) {
      for (auto&& [handle, callback] : m_callbacks) {
        try {
          callback(args...);
        } catch (...) {
          // Catch exceptions to ensure all subscribers are notified
        }
      }
    }
    
    std::unordered_map<handle_t, callback_t> m_callbacks;
    handle_t m_next_handle = 0;
  };
  
} // namespace observers

#endif /* INCLUDED_OBSERVERS_EVENTS_HPP */
