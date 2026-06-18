# assigment part 2: multicore comunication with strings

## observation of the original example
- **issue:** the original example didnt show any output because it was configured to use usb serial, which requires a serial terminal conection. also, the leds were mapped to gpio 14 and 15, which are not the default onboard leds.
- **behavior:** the original code sent single characters from core 0 to core 1 using the fifo register.

## changes made: strings instead of chars
to use strings instead of characters, i made the following architectural changes:

1. **memory sharing:** in the rp2040, both cores share the same memory space. instead of pushing the actual data through the fifo (which is only 32 bits wide), i now push the **memory adress** (pointer) of a string buffer.
2. **buffering in core 0:** 
   - i added a `message_buffer` (char array) and a `buffer_index`.
   - core 0 now collects characters from `stdio` and stores them in the buffer.
   - when a newline (`\n` or `\r`) is detected, it null-terminates the string and sends the pointer to core 1.
3. **core 1 processing:**
   - the irq handler on core 1 pops the 32-bit value from the fifo.
   - it casts this value back to a `char *`.
   - it uses `printf` with the `%s` format specifier to print the entire string.

## how to test
1. **build and flash:** rebuild the project and flash the new `.uf2` file.
2. **serial terminal:** open a serial terminal (e.g., putty, serial monitor) at 115200 baud.
3. **input:** type a word and press **enter**.
4. **output:** 
   - core 0 will echo your characters.
   - upon pressing enter, core 0 will show "sending: ...".
   - core 1 will imediately respond with "core 1 received string: ...".

## technical note
since both cores access the same `message_buffer`, there is a potential race condition if core 0 starts writing a new message before core 1 finishes printing the old one. in this implementation, the `printf` on core 0 and the delay in the loop provide enough time for core 1 to process the string, but in a production enviroment, a semaphore or mutex should be used to sincronize access to the shared buffer.
