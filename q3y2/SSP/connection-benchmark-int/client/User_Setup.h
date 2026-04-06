// User_Setup.h — LilyGo T-Display v1.1 (ESP32 + ST7789 135x240)

#define ST7789_DRIVER          // T-Display uses ST7789, NOT ILI9341

#define TFT_WIDTH  135
#define TFT_HEIGHT 240

// T-Display v1.1 hardware SPI pins
#define TFT_MOSI  19
#define TFT_SCLK  18
#define TFT_CS    5
#define TFT_DC    16
#define TFT_RST   23
#define TFT_BL    4            // Backlight — CRITICAL: must be driven HIGH or screen stays black

#define TFT_BACKLIGHT_ON HIGH

#define LOAD_GLCD
#define LOAD_FONT2
#define LOAD_FONT4
#define LOAD_FONT6
#define LOAD_FONT7
#define LOAD_FONT8
#define LOAD_GFXFF
#define SMOOTH_FONT

#define SPI_FREQUENCY       27000000
#define SPI_READ_FREQUENCY  20000000
