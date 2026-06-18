#include <Arduino.h>

const int ledPins[] = {D7, D6, D5};
const int numLeds = 3;

const int buttonPin = D4;

int currentLed = 0;
bool lastButtonState = LOW;

void setup() {
  // LEDs
  for (int i = 0; i < numLeds; i++) {
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW);
  }

  // Button input.
  // Assumes a button configuration with a pull-down resistor.
  pinMode(buttonPin, INPUT);

  Serial.begin(9600);
  Serial.println("Ready");
}

void loop() {
  bool buttonState = digitalRead(buttonPin);

  // Detect rising edge - button press (LOW -> HIGH).
  if (buttonState == HIGH && lastButtonState == LOW) {
    // Turn off all LEDs.
    for (int i = 0; i < numLeds; i++) {
      digitalWrite(ledPins[i], LOW);
    }

    // Turn on current LED.
    digitalWrite(ledPins[currentLed], HIGH);

    Serial.print("LED ");
    Serial.println(currentLed);

    // Advance to next LED.
    currentLed = (currentLed + 1) % numLeds;

    delay(200);
  }

  lastButtonState = buttonState;
}
