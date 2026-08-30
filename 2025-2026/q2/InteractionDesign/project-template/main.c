#include <stdio.h>
#include <string.h> 
#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "hardware/adc.h"


#define LED_PIN 20
#define ADC_PIN 26


#define ADC_RESOLUTION 4096.0f 
#define ADC_VREF 3.3f 
#define MAX_COMMAND_LEN 16

void print_help() {
    printf("\n--- Commands ---\n");
    printf("on   = LED on\n");
    printf("off  = LED off\n");
    printf("help = Display this menu\n");
    printf("q    = Quit \n");
    printf("----------------\n");
}

int main()
{
    
    stdio_init_all();

    
    float biggest_voltage = 0.0f;
    float smallest_voltage = ADC_VREF; 

    
    char command_buffer[MAX_COMMAND_LEN];
    int command_index = 0;
    memset(command_buffer, 0, sizeof(command_buffer)); 

    
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);
    gpio_put(LED_PIN, 0); 

    
    adc_init();
    adc_gpio_init(ADC_PIN); 
    adc_select_input(0); 

    
    absolute_time_t last_adc_time = get_absolute_time();
    const uint32_t adc_interval_us = 3000000; 

    printf("Pico LED and ADC Control Program\n");
    print_help();

    while (true) {
        
        int ch = getchar_timeout_us(0);

        if (ch != PICO_ERROR_TIMEOUT) {
            
            if (ch == '\r' || ch == '\n') { 
                if (command_index > 0) {
                    command_buffer[command_index] = '\0'; 
                    
                    
                    if (strcmp(command_buffer, "on") == 0) {
                        gpio_put(LED_PIN, 1);
                        printf("LED on\n");
                    }
                    else if (strcmp(command_buffer, "off") == 0) {
                        gpio_put(LED_PIN, 0);
                        printf("LED off\n");
                    }
                    else if (strcmp(command_buffer, "help") == 0) {
                        print_help();
                    }
                    else {
                        printf("Unknown command: %s\n", command_buffer);
                    }
                    
                    
                    command_index = 0;
                    memset(command_buffer, 0, sizeof(command_buffer));
                }
            } 
            
            else if (ch >= ' ' && command_index < MAX_COMMAND_LEN - 1) { 
                
                putchar(ch);
                
                
                command_buffer[command_index++] = (char)ch;
            }
        }

        
        absolute_time_t current_time = get_absolute_time();
        int64_t time_diff = absolute_time_diff_us(last_adc_time, current_time);
        
        
        if (time_diff >= adc_interval_us) {
            uint16_t adc_value = adc_read(); 
            
            
            float voltage = ((float)adc_value / ADC_RESOLUTION) * ADC_VREF;

            
            if(voltage > biggest_voltage) biggest_voltage = voltage;
            if(voltage < smallest_voltage) smallest_voltage = voltage;
            
            
            printf("\nVoltage: %.3f V, Smallest: %.3f V, Biggest: %.3f V\n", 
                   voltage, smallest_voltage, biggest_voltage);
            
            last_adc_time = current_time;
        }

        
        sleep_ms(1);
    }
}
