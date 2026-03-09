# Dasai Mochi - Raspberry Pi Pico W Project

A project using Raspberry Pi Pico W with SSD1315 OLED display (I2C) and MicroPython.

## Hardware Requirements
- Raspberry Pi Pico W
- SSD1315 OLED Display (128x64, I2C)
- Jumper wires
- USB cable

## Wiring - SSD1315 OLED (I2C)
| OLED Pin | Pico W Pin |
|----------|------------|
| VCC      | 3.3V (Pin 36) |
| GND      | GND (Pin 38) |
| SCL      | GP1 (Pin 2) |
| SDA      | GP0 (Pin 1) |

You can use any GPIO pins for I2C, but GP0/GP1 are common defaults.

## Setup Instructions

### 1. Install MicroPython on Pico W
1. Download the latest MicroPython firmware for Pico W from: https://micropython.org/download/rp2-pico-w/
2. Hold the BOOTSEL button on Pico W and plug it into your computer
3. Drag and drop the `.uf2` file to the RPI-RP2 drive
4. The Pico W will reboot and appear as a serial device

### 2. Install Development Tools
```bash
# Install Thonny IDE (easiest for beginners)
sudo apt install thonny

# Or use ampy for command-line file transfer
pip install adafruit-ampy

# Or use rshell
pip install rshell
```

### 3. Upload Files to Pico W
Using Thonny:
- Open Thonny IDE
- Select "MicroPython (Raspberry Pi Pico)" from the interpreter menu
- Save files directly to the Pico W

Using ampy:
```bash
# Upload library
ampy --port /dev/ttyACM0 put ssd1306.py

# Upload config
ampy --port /dev/ttyACM0 put config.py

# Upload main code
ampy --port /dev/ttyACM0 put main.py
```

### 4. Run the Code
The `main.py` file runs automatically on boot. To test without rebooting:
- In Thonny, press F5 or click Run
- Or use the REPL console

## Project Structure
```
dasaimochirpi/
├── main.py           # Main application code
├── config.py         # WiFi credentials and settings
├── ssd1306.py        # OLED display driver
├── display.py        # Display helper functions
└── README.md         # This file
```

## Features to Build
- [x] OLED display initialization
- [x] WiFi connectivity
- [ ] Display Dasai countdown
- [ ] Show time/date
- [ ] Display festive messages
- [ ] Web server for remote updates
- [ ] Temperature/weather display
- [ ] Custom animations

## Resources
- [MicroPython Docs](https://docs.micropython.org/)
- [Pico W Documentation](https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html)
- [SSD1306 Driver](https://github.com/micropython/micropython/blob/master/drivers/display/ssd1306.py)
