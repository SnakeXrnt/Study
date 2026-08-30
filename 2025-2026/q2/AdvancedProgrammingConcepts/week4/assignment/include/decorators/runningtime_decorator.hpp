

#include "decorator.hpp"
#include <chrono>
#include <string>

namespace extensions {
    class runningtime_decorator : decorator {
        public: 
            using decorator::decorator;

            void log(const std::string& msg) const;


        private:

            static inline const std::chrono::high_resolution_clock::time_point START_TIME =  std::chrono::high_resolution_clock::now();


    };
}
