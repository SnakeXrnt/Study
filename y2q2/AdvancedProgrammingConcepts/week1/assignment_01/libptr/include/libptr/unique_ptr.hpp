#ifndef INCLUDED_LIBPTR_UNIQUE_PTR_H
#define INCLUDED_LIBPTR_UNIQUE_PTR_H

// You can use sax::DefaultDeleter from deleter.hpp if you are implementing the optional part
#include "deleter.hpp"
#include <algorithm>
#include <utility>
#include <type_traits>

namespace sax
{
    template <typename T, typename Deleter = sax::DefaultDeleter<T>>
    class UniquePtr
    {   
    public:
        using Pointer = T*;
        using ElementType = T;
        using DeleterType = Deleter;
    
    private:
        // the real pointer
        Pointer ptr_{nullptr};
        DeleterType deleter_{};

    public:
        // Constructors etc.
        // UniquePtr(Pointer ptr) : ptr_{ptr} {}
        // UniquePtr() : ptr_{nullptr} {}
        
        UniquePtr(Pointer ptr = nullptr, DeleterType deleter = DeleterType{}) : ptr_{ptr}, deleter_{std::move(deleter)} {}

        UniquePtr(const UniquePtr&) = delete;
        UniquePtr& operator=(const UniquePtr&) = delete;

        UniquePtr(UniquePtr&& other) : ptr_{other.ptr_} , deleter_{std::move(other.deleter_)} {
            other.ptr_ = nullptr;
        }

        ~UniquePtr() {
            if (ptr_) {
                deleter_(ptr_);
            }
        }

        UniquePtr& operator=(UniquePtr&& other){
            if (this != &other) {
                reset();    
                deleter_ = std::move(other.deleter_);
                ptr_ = other.ptr_;    
                other.ptr_ = nullptr; 
            }
            return *this;
        }


        // Modifiers

        Pointer release() {
            Pointer p = ptr_;
            ptr_ = nullptr;
            return p;
        }

        void reset(Pointer p = nullptr) {
            if (ptr_ != p) {
                if (ptr_) {
                    deleter_(ptr_);
                }
                ptr_ = p;
            }
        }

        void swap(UniquePtr& other) {
            using std::swap;
            swap(ptr_, other.ptr_);
            swap(deleter_, other.deleter_);
        }

        // Observers

        Pointer get() const {return ptr_;}
        operator bool() const {return ptr_!=nullptr;}
        

        

        // Pointer-like operators
        ElementType& operator*() const {return *ptr_;}
        Pointer operator->() const {return ptr_;} 

        Deleter& get_deleter() {
            return deleter_;
        }    
    };

    template <typename T, typename Deleter>
    void swap(UniquePtr<T, Deleter>& lhs, UniquePtr<T, Deleter>& rhs) {
        lhs.swap(rhs);
    }
}

#endif /* INCLUDED_LIBPTR_UNIQUE_PTR_H */
