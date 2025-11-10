#include "pico/stdlib.h"
#include "stdio.h"

#define LED_START 2
#define LED_COUNT 9
#define START_BTN 0 
#define STOP_BTN 1

#define LED_MASK (((1 << LED_COUNT) - 1) << LED_START)

volatile bool scanning = false ;  

// one general gpio callback function
void gpio_callback(uint gpio, uint32_t events) {
	if (gpio == START_BTN && (events & GPIO_IRQ_EDGE_RISE)) {
		scanning = true;
	} 
	else if (gpio == STOP_BTN && (events & GPIO_IRQ_EDGE_FALL)) {
	 scanning = false;
	} 
}

int main() {
  stdio_init_all();
  
  gpio_init_mask(LED_MASK);
  gpio_set_dir_out_masked(LED_MASK);
  gpio_clr_mask(LED_MASK);

	gpio_init_mask( (1<<START_BTN) | (1 <<STOP_BTN) );
 	gpio_set_dir_in_masked( (1<<START_BTN) | (1 << STOP_BTN) );
	gpio_pull_up(START_BTN);
  gpio_pull_up(STOP_BTN);

  gpio_set_irq_enabled_with_callback(START_BTN, GPIO_IRQ_EDGE_RISE, true, &gpio_callback);
  gpio_set_irq_enabled(STOP_BTN, GPIO_IRQ_EDGE_FALL,true);

  int pos = 0;
  int dir = 1;

  while(true) {
    if (scanning) {
      gpio_clr_mask(LED_MASK);

      gpio_set_mask(
        (pos == 0 || pos == LED_COUNT - 1) 
        ? 1 << (LED_START + pos) 
        : (1 << (LED_START + pos) | (1 << (LED_START + pos + dir)))
      );

      pos += dir;
      if (pos == LED_COUNT - 1 || pos == 0) {
        dir = -dir;
      }

      sleep_ms(50);

    } else {
      tight_loop_contents();
    }
  }

}
