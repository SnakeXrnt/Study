#include <Arduino.h>

int led1 = 25;
int led2 = 26;
int led3 = 27;
int button = 0; // Built-in "Boot"

int activeLed = 0;

void setup() {
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);

  pinMode(button, INPUT_PULLUP);

  digitalWrite(led1, HIGH);
  activeLed = 1;
}

void loop() {
   if (digitalRead(button) == LOW) {

    digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    digitalWrite(led3, LOW);

    activeLed = activeLed + 1;

    if (activeLed > 3) {
      activeLed = 1;
    }

    if (activeLed == 1) digitalWrite(led1, HIGH);
    if (activeLed == 2) digitalWrite(led2, HIGH);
    if (activeLed == 3) digitalWrite(led3, HIGH);

    delay(250);
  }
}
