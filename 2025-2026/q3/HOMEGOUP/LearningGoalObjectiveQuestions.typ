
#let font_size = 10pt

#set text(
  font: "Zed Sans Extended",
  size: font_size,
)
#set par(justify: true)
#set heading(numbering: "1.")
#set page(numbering: "1")

#show link: set text(blue)
#show link: underline

#set page(
  paper: "us-letter",
  header: align(right)[
    Ethan Bastian 560704 \
    Homegroups Research
  ],
)

#align(
  horizon,
  [
    #align(
      center,
      text(4 * font_size)[
        *Homegroups*
      ],
    )
    #align(center)[
      Research Assignment 

  ]
  ],
)

#show raw.where(block: false): it => box(
  fill: rgb("#f2f3f5"),
  stroke: 0.5pt + luma(200),
  radius: 3pt,
  inset: (x: 3pt, y: 1pt),
  baseline: 10%,
  it,
)

#show raw.where(block: true): it => block(
  fill: rgb("#f2f3f5"),
  stroke: 0.5pt + luma(200),
  radius: 4pt,
  inset: (top: 18pt, rest: 10pt), // Extra top padding to make room for the language badge
  width: 100%,
  clip: false,
  stack(
    dir: ttb,
    spacing: 0pt,
    place(
      top + right,
      dx: -5pt,
      dy: -13pt,
      box(
        fill: luma(220),
        inset: (x: 5pt, y: 2pt),
        radius: 3pt,
        stroke: 0.5pt + luma(180),
        text(size: 7.5pt, weight: "bold", fill: luma(80), upper(if it.has("lang") { it.lang } else { "code" })),
      ),
    ),
    text(size: 9.5pt, font: "JetBrainsMono NF", it),
  ),
)

#pagebreak()

#outline()

#pagebreak()

= Learning Goal
To gain a deeper understanding of how to efficiently transmit structured sensor data, such as 6 raw IMU readings (36 floating-point values) or compact enum-based commands over BLE between the wearable unit (Arduino Nano BLE 33 Sense) and the ESP32 TTGO, while maintaining data integrity, maximizing throughput, and ensuring the connection recovers automatically from drops.

= Learning Objectives (SMART)
1. Design and implement at least 2 BLE packet structures (for example packed raw floats vs. a compact binary struct) for transmitting 6 IMU sensor readings (36 `float` values +- 144 bytes), and measure their throughput and data-loss rate, by end of Q3.

2. Implement and compare a lightweight enum-based command protocol against a raw value protocol for control signals, evaluating parse reliability and latency over BLE, during the Building stage.

3. Validate that received data is byte-correct and numerically intact (no corruption or endianness errors) across at least 100 consecutive BLE packets under normal operating conditions, by the Testing stage (Mid–End Q4).

4. Implement and verify an automatic reconnection mechanism that restores the BLE link within 5 seconds of an unintentional drop, without requiring user intervention, by the Testing stage.

5. Document the trade-offs between packet size, serialization strategy, and connection reliability to justify the final data protocol choice.

= Research Question
"What is the most efficient BLE data protocol for transmitting 6 raw IMU sensor readings (36 floating-point values) or enum-based commands from the Arduino Nano BLE 33 Sense to the ESP32 TTGO, such that data remains clean accurate, transmission latency is minimized, and the connection recovers automatically?"
