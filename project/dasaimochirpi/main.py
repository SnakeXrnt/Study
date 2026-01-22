"""
Dasai Mochi - Raspberry Pi Pico W Main Application
Displays festive messages and connects to WiFi
"""
import network
import time
from machine import Pin
from display import Display
import config


def connect_wifi():
    """Connect to WiFi network"""
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    
    if not wlan.isconnected():
        print(f"Connecting to WiFi: {config.WIFI_SSID}")
        wlan.connect(config.WIFI_SSID, config.WIFI_PASSWORD)
        
        # Wait for connection with timeout
        max_wait = 10
        while max_wait > 0:
            if wlan.isconnected():
                break
            max_wait -= 1
            print("Waiting for connection...")
            time.sleep(1)
    
    if wlan.isconnected():
        status = wlan.ifconfig()
        print(f"Connected! IP: {status[0]}")
        return True, status[0]
    else:
        print("Failed to connect to WiFi")
        return False, None


def main():
    """Main application"""
    # Turn on onboard LED
    led = Pin("LED", Pin.OUT)
    led.on()
    
    # Initialize display
    print("Initializing display...")
    display = Display()
    
    # Show startup message
    display.show_message("Dasai Mochi", "Starting...")
    time.sleep(2)
    
    # Connect to WiFi
    display.show_message("Connecting", "to WiFi...")
    connected, ip = connect_wifi()
    
    if connected:
        display.clear()
        display.center_text("Connected!", 16)
        display.center_text(ip[:15], 32)  # Show IP (truncated)
        display.show()
        time.sleep(3)
        led.off()
        time.sleep(0.5)
        led.on()
    else:
        display.show_message("WiFi Failed", "Check config")
        time.sleep(3)
    
    # Main loop - display festive message
    message_index = 0
    messages = [
        ("Dasai", "Mochi"),
        ("Happy", "Dashain!"),
        ("Subha", "Bijaya!"),
    ]
    
    while True:
        try:
            # Clear and show current message
            display.clear()
            display.draw_border()
            msg = messages[message_index]
            display.center_text(msg[0], 24)
            display.center_text(msg[1], 36)
            display.show()
            
            # Blink LED
            led.toggle()
            
            # Next message
            message_index = (message_index + 1) % len(messages)
            time.sleep(3)
            
        except KeyboardInterrupt:
            print("Stopped by user")
            break
        except Exception as e:
            print(f"Error: {e}")
            display.show_message("Error!", str(e)[:16])
            time.sleep(5)


if __name__ == "__main__":
    main()
