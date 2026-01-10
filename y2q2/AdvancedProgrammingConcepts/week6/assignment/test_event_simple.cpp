#include <iostream>
#include "libobs/observers/events.hpp"

void button_clicked_handler(int how_many) {
    std::cout << "Button was clicked " << how_many << " times!\n";
}

struct Button {
    observers::event<Button, int> clicked;

    void simulate_click(int how_many) {
        // Notify the subscribers about the click event
        clicked(how_many);
    }
};

int main() {
    Button button;
    
    // Subscribe to the event with a free function
    auto handle1 = button.clicked += button_clicked_handler;
    std::cout << "Subscribed with handle: " << handle1 << "\n";
    
    // And with a lambda expression
    auto handle2 = button.clicked += [](int how_many) {
        std::cout << "Lambda: Button clicked " << how_many << " times!\n";
    };
    std::cout << "Subscribed with handle: " << handle2 << "\n";
    
    // Simulate a button click by notifying the subscribers
    button.simulate_click(42);
    
    // Unsubscribe the first handler
    if (button.clicked -= handle1) {
        std::cout << "Successfully unsubscribed handle " << handle1 << "\n";
    }
    
    // Click again - only lambda should respond
    button.simulate_click(24);
    
    return 0;
}
