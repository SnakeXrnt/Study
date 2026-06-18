/*
 * Arduino.h wrapper that fixes macro pollution
 * This overrides the system Arduino.h
 */

// Include the real Arduino.h from the framework
#include_next <Arduino.h>

// Immediately undefine problematic macros after Arduino.h
// See: https://github.com/arduino/ArduinoCore-mbed/issues/8
#ifdef abs
#undef abs
#endif

#ifdef min
#undef min
#endif

#ifdef max
#undef max
#endif

#ifdef round
#undef round
#endif

#ifdef constrain
#undef constrain
#endif
