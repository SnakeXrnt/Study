# dmx 512 assignemnt

## what i did
started by looking at the given `hello.pio` template. the break part was already there, holding the pin low for 124us (31 loops * 4us). 
my job was to add the MAB (mark after break) and the actual data transmission part.

## timing calculations
the most important part of this is the timing. the pico runs at 125mhz. we set the pio clock div to 125.0 in the c code `sm_config_set_clkdiv(&c, 125.0f);`.
this is super nice becuase: 125mhz / 125 = 1mhz. so 1 pio cycle is exactly 1us.
dmx runs at 250kbaud. 1 / 250000 = 4us per bit. so every bit needs to take exactly 4 cyles in pio.

## writing the pio code
1. **mab:** after the break, the line needs to go high for at least 8us. i set it high and looped it for 12us total just to be safe.
2. **data loop:** 
    - first it pulls the amount of bytes from osr (copied to y register). 
    - inside `byte_loop`, it pulls the actual data byte.
    - **start bit:** line goes low for 4us (`set pins, 0 [3]`).
    - **data bits:** made a `bit_loop` that shifts out 8 bits, 4us each (`out pins, 1 [3]`). it shifts right (lsb first) becuase of `sm_config_set_out_shift(&c, true, false, 8);`.
    - **stop bits:** line goes high for 8us (2 stop bits, `set pins, 1 [7]`).
    - repeats for all bytes (`jmp y-- byte_loop`).

## c code and testing
in `hello.c`, the cpu sends 512 (number of channels + start code) to tell pio how many bytes to expect. then it sends the start code (0x00) and 512 channels of data.

to test it, i added a heartbeat to the onboard led. im using the yd-rp2040 board, so the standard led is on gpio 25 (the blue one, not the rgb neopixel on gpio 23).
i turn the led on before feeding the pio fifo, and off after.
flashed it and the blue led blinks real fast. this proves the pio state machine is chewing through the data and not getting stuck waiting in the fifo. next step would be hookign it up to a max485 chip to drive a real light.
