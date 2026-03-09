"""
Display helper functions for SSD1315 OLED
"""
from machine import Pin, I2C
from ssd1306 import SSD1306_I2C
import config


class Display:
    def __init__(self):
        # Initialize I2C
        self.i2c = I2C(0, 
                      sda=Pin(config.I2C_SDA_PIN), 
                      scl=Pin(config.I2C_SCL_PIN), 
                      freq=config.I2C_FREQ)
        
        # Scan for I2C devices
        devices = self.i2c.scan()
        if devices:
            print(f"I2C devices found: {[hex(d) for d in devices]}")
        else:
            print("No I2C devices found!")
        
        # Initialize display (SSD1315 is compatible with SSD1306 driver)
        # Common I2C addresses: 0x3C or 0x3D
        self.oled = SSD1306_I2C(config.DISPLAY_WIDTH, config.DISPLAY_HEIGHT, self.i2c)
        self.width = config.DISPLAY_WIDTH
        self.height = config.DISPLAY_HEIGHT
        
    def clear(self):
        """Clear the display"""
        self.oled.fill(0)
        
    def show(self):
        """Update the display"""
        self.oled.show()
        
    def text(self, text, x, y, color=1):
        """Display text at position"""
        self.oled.text(text, x, y, color)
        
    def center_text(self, text, y, color=1):
        """Display centered text"""
        x = (self.width - len(text) * 8) // 2
        self.oled.text(text, x, y, color)
        
    def show_message(self, line1, line2=None, line3=None):
        """Display up to 3 lines of text (centered)"""
        self.clear()
        self.center_text(line1, 16)
        if line2:
            self.center_text(line2, 32)
        if line3:
            self.center_text(line3, 48)
        self.show()
        
    def draw_border(self):
        """Draw a border around the display"""
        self.oled.rect(0, 0, self.width, self.height, 1)
        
    def progress_bar(self, x, y, width, height, percent):
        """Draw a progress bar"""
        self.oled.rect(x, y, width, height, 1)
        fill_width = int((width - 2) * percent / 100)
        if fill_width > 0:
            self.oled.fill_rect(x + 1, y + 1, fill_width, height - 2, 1)
