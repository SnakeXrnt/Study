#include <stdio.h>
#include <string.h>
#include <pico/stdlib.h>
#include <hardware/i2c.h>

#define I2C_PORT i2c0
#define I2C_SDA 8
#define I2C_SCL 9

#define INA238_ADRES 0x45  
#define SHUNT_VOLTAGE_REG 0x04 
#define BUS_VOLTAGE_REG 0x05    
#define POWER_REG 0x08          
#define CURRENT_REG 0x07       

#define MAX17048_ADDR 0x36    
#define VCELL_REG 0x02        
#define SOC_REG 0x04          

#define GPIO_EXTERNAL_LED 16
#define GPIO_SERVO 17
#define GPIO_INTERNAL_LED 18
#define GPIO_SLEEP_TRIGGER 19

// INA238 current LSB calculation
// Assuming Rshunt = 0.01 ohm, Max Current = 10A
// CURRENT_LSB = Max Current / 2^19 = 10A / 524288 ≈ 19.073 µA/bit
#define CURRENT_LSB 0.000019073  // in Amperes

float ina238_getShuntVoltage();
float ina238_getCurrent();
float ina238_getPower();

void set_mode_external() {
    gpio_put(GPIO_EXTERNAL_LED, 1);
    gpio_put(GPIO_SERVO, 0);
    gpio_put(GPIO_INTERNAL_LED, 0);
    gpio_put(GPIO_SLEEP_TRIGGER, 0);
    printf("\n External LED   (GPIO 16 pulse 10ms)\n");
    sleep_ms(10);
    gpio_put(GPIO_EXTERNAL_LED, 0);
}

void set_mode_internal() {
    gpio_put(GPIO_EXTERNAL_LED, 0);
    gpio_put(GPIO_SERVO, 0);
    gpio_put(GPIO_INTERNAL_LED, 1);
    gpio_put(GPIO_SLEEP_TRIGGER, 0);
    printf("\n Internal LED   (GPIO 18 pulse 10ms)\n");
    sleep_ms(10);
    gpio_put(GPIO_INTERNAL_LED, 0);
}

void set_mode_servo() {
    gpio_put(GPIO_EXTERNAL_LED, 0);
    gpio_put(GPIO_SERVO, 1);
    gpio_put(GPIO_INTERNAL_LED, 0);
    gpio_put(GPIO_SLEEP_TRIGGER, 0);
    printf("\n Servo mode  (GPIO 17 pulse 10ms)\n");
    sleep_ms(10);
    gpio_put(GPIO_SERVO, 0);
}

void set_mode_sleep() {
    gpio_put(GPIO_EXTERNAL_LED, 0);
    gpio_put(GPIO_SERVO, 0);
    gpio_put(GPIO_INTERNAL_LED, 0);
    gpio_put(GPIO_SLEEP_TRIGGER, 1);
    printf("\n  Sleep mode (GPIO 19 HIGH)\n");
}

int main()
{
    stdio_init_all();

    i2c_init(I2C_PORT, 400*1000);
    
    gpio_set_function(I2C_SDA, GPIO_FUNC_I2C);
    gpio_set_function(I2C_SCL, GPIO_FUNC_I2C);
    gpio_pull_up(I2C_SDA);
    gpio_pull_up(I2C_SCL);

    gpio_init(GPIO_EXTERNAL_LED);
    gpio_set_dir(GPIO_EXTERNAL_LED, GPIO_OUT);
    gpio_put(GPIO_EXTERNAL_LED, 0);
    
    gpio_init(GPIO_SERVO);
    gpio_set_dir(GPIO_SERVO, GPIO_OUT);
    gpio_put(GPIO_SERVO, 0);
    
    gpio_init(GPIO_INTERNAL_LED);
    gpio_set_dir(GPIO_INTERNAL_LED, GPIO_OUT);
    gpio_put(GPIO_INTERNAL_LED, 0);
    
    gpio_init(GPIO_SLEEP_TRIGGER);
    gpio_set_dir(GPIO_SLEEP_TRIGGER, GPIO_OUT);
    gpio_put(GPIO_SLEEP_TRIGGER, 0);

    printf("  'r' - Read power measurements\n");
    printf("  'external' - External LED mode (GPIO 16)\n");
    printf("  'internal' - Internal LED mode (GPIO 18)\n");
    printf("  'servo' - Servo mode (GPIO 17)\n");
    printf("  'sleep' - Sleep mode (GPIO 19)\n");

    char command_buffer[20] = {0};
    int command_index = 0;

    while (true) {
        int c = getchar_timeout_us(0);
        
        if (c != PICO_ERROR_TIMEOUT) {
            if (c == '\n' || c == '\r') {
                command_buffer[command_index] = '\0';
                if (strcmp(command_buffer, "r") == 0) {
                    printf("\nreading \n");
                    float shuntVoltage = ina238_getShuntVoltage();
                    printf("Shunt Voltage: %.6f V\n", shuntVoltage);
                    
                    float current = ina238_getCurrent();
                    printf("Current: %.6f A\n", current);
                    
                    float power = ina238_getPower();
                    printf("Power: %.6f W\n", power);
                } else if (strcmp(command_buffer, "external") == 0) {
                    set_mode_external();
                } else if (strcmp(command_buffer, "internal") == 0) {
                    set_mode_internal();
                } else if (strcmp(command_buffer, "servo") == 0) {
                    set_mode_servo();
                } else if (strcmp(command_buffer, "sleep") == 0) {
                    set_mode_sleep();
                }
                
                command_index = 0;
                command_buffer[0] = '\0';
            } else if (command_index < 19) {
                command_buffer[command_index++] = c;
                printf("%c", c); 
            }
        }
        
        sleep_ms(10);  // Small delay to prevent busy-waiting
    }
}

float ina238_getShuntVoltage(){
    uint8_t buf[2];
    uint8_t reg = SHUNT_VOLTAGE_REG;
    i2c_write_blocking(I2C_PORT, INA238_ADRES, &reg, 1, true);
    i2c_read_blocking(I2C_PORT, INA238_ADRES, buf, 2, false);
    int16_t result = (buf[0] << 8) | buf[1];
    return (float)result * 5.0 / 1000000.0;  // LSB = 5 µV
}

float ina238_getCurrent(){
    uint8_t buf[2];
    uint8_t reg = CURRENT_REG;
    i2c_write_blocking(I2C_PORT, INA238_ADRES, &reg, 1, true);
    i2c_read_blocking(I2C_PORT, INA238_ADRES, buf, 2, false);
    int16_t result = (buf[0] << 8) | buf[1];
    // Current[A] = current_lsb * current_register_value
    return (float)result * CURRENT_LSB;
}

float ina238_getPower(){
    uint8_t buf[2];
    uint8_t reg = POWER_REG;
    i2c_write_blocking(I2C_PORT, INA238_ADRES, &reg, 1, true);
    i2c_read_blocking(I2C_PORT, INA238_ADRES, buf, 2, false);
    uint16_t result = (buf[0] << 8) | buf[1];
    // Power[W] = 0.2 * current_lsb * POWER_register_value
    return 0.2 * CURRENT_LSB * (float)result;
}