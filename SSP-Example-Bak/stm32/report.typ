#show link: set text(fill: blue)

#set page(
  header: [
    #align(center)[
      #datetime.today().display()
      #h(1fr)
      Team 7
      #h(1fr)
      Kiril Strezikozin
    ]
  ],
)

#align(
  center,
  [
    = STM32 Nucleo 144 (B-L475E-IOT01A2)
  ],
)

= Main features

A *development kit* designed for Internet of Things (IoT)
applications, featuring a low-power STM32L4 series
microcontroller with integrated wireless connectivity.

- *CPU*: STM32L475VGT6, an Arm Cortex-M4 based microcontroller
  with 1 MB Flash memory and 128 KB SRAM
- *WiFi* module 802.11 b/g/n (ISM43362-M3G-L44 module on board)
- *Bluetooth* 4.1 BLE (SPBTLE-RF module)
- *IMU*: Gyroscope and accelerometer (LSM6DSL module)
- *IMU*: Magnetometer (LIS3MDL module)
- Other sensors

#link("https://www.digikey.com/htmldatasheets/production/2263149/0/0/1/b-l475e-iot01a-user-manual.html", [User Manual]).

== Advantages

- Affordable all-in development board.
- Perfect for prototyping without the need to attach other sensors.
- IMUs included in the kit, perfect for our project.
- Wireless communication modules included in the kit.
- No need for a separate probe for debugging:
  ST-LINK/V2-1 debugger/programmer with USB re-enumeration
  (mass storage, Virtual COM port, debug port).
- Unused sensors can be disabled for low-power applications.

== Disadvantages

- Requires a separate battery adapter to control
  charging/discharging for battery-driven applications.
- Bulky, the development kit is quite large.

= Toolchain and IDE

PlatformIO, mbed is supported. C/C++ SDK. GCC/LLVM-based IDEs.
STM32 libraries.

= Learning curve

Not steep for basic functionality and when working with STM32
libraries. STM32 ecosystem has got libraries for all the modules
we may require programming if this board is selected.

= Implementation difficulty: Serial and WiFi

The biggest difficulty is finding the right libraries.
Serial is not difficult if using the Arduino framework.
WiFi setup requires a specialized library.
