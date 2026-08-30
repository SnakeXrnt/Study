/*
 * Arduino macro fix header
 * This file is automatically included before all source files via -include flag
 * to fix Arduino macro pollution issues with C++ standard library
 */

#ifndef ARDUINO_FIX_H
#define ARDUINO_FIX_H

// Only apply the fix after Arduino.h has been included
#ifdef ARDUINO

// Undefine problematic Arduino macros that conflict with C++ standard library
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

#endif // ARDUINO

#endif // ARDUINO_FIX_H
