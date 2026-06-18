#include <Arduino.h>

const int ledPins[] = {D7, D6, D5};
const int numLeds = 3;

bool ledState[numLeds] = {false, false, false};

void setup() {
  Serial.begin(9600);

  for (int i = 0; i < numLeds; i++) {
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW);
  }

  Serial.println("Ready. Send LED index (0-2) to toggle.");
}

void toggleLed(int index) {
  ledState[index] = !ledState[index];
  digitalWrite(ledPins[index], ledState[index] ? HIGH : LOW);

  Serial.print("LED ");
  Serial.print(index);
  Serial.print(" -> ");
  Serial.println(ledState[index] ? "ON" : "OFF");
}

void loop() {
  if (Serial.available() > 0) {
    int value = Serial.read() - '0';

    // Flush the rest of the line (CR/LF)
    while (Serial.available()) {
      Serial.read();
    }

    if (value >= 0 && value < numLeds) {
      toggleLed(value);
    } else {
      Serial.print("Invalid LED index: ");
      Serial.println(value);
    }
  }
}
