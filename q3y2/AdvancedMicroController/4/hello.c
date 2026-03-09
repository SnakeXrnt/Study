#include <stdint.h>
#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/i2c.h"

float get_current_amps() {
    uint8_t reg = 0x04;
    uint8_t data[2];

    i2c_write_blocking(i2c0, 0x45, &reg, 1, true);
    i2c_write_blocking(i2c0, 0x45, data, 2, true);

    int16_t raw = (int16_t)((data[0] << 8) | data[1]);

    float shunt_volts = raw * 0.000005f;

    return shunt_volts / 0.1;
    
}

int main() {
    stdio_init_all();
    i2c_init(i2c0, 100000);
    gpio_set_function(4, GPIO_FUNC_I2C); 
    gpio_set_function(5, GPIO_FUNC_I2C); 
    gpio_pull_up(4);
    gpio_pull_up(5);

    
    const uint TRIGGER_PIN = 16;
    gpio_init(TRIGGER_PIN);
    gpio_set_dir(TRIGGER_PIN, GPIO_IN);
    gpio_pull_down(TRIGGER_PIN); 

    


    while (true) {
        if (gpio_get(TRIGGER_PIN)) {
            printf("TRIGGER HIGH | CURRENT : %.4f A\n", get_current_amps());
        } else {
            printf("TRIGGER LOW | CURRENT : %.4f A\n", get_current_amps());
        } 
        sleep_ms(500);
    }
}
