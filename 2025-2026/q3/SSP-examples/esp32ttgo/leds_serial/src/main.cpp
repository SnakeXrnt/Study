#include <Arduino.h>
#include <WiFi.h>
#include <WiFiUdp.h>

const char* ssid = "ACSlab";
const char* password = "lab@ACS24";
unsigned int localPort = 4210;

int led1 = 25;
int led2 = 26;
int led3 = 27;

WiFiUDP udp;
char packetBuffer[255];

void setup() {
  Serial.begin(115200);

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);

  Serial.print("Connecting to WiFi");
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nConnected!");

  Serial.print("My IP Address: ");
  Serial.println(WiFi.localIP());

  udp.begin(localPort);
  Serial.print("Listening on UDP port: ");
  Serial.println(localPort);
}

void loop() {
  int packetSize = udp.parsePacket();

  if (packetSize) {
    int len = udp.read(packetBuffer, 255);
    if (len > 0) {
      packetBuffer[len] = 0;
    }

    Serial.print("Received: ");
    Serial.println(packetBuffer);

    digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    digitalWrite(led3, LOW);

    if (packetBuffer[0] == '1') {
      digitalWrite(led1, HIGH);
    }
    else if (packetBuffer[0] == '2') {
      digitalWrite(led2, HIGH);
    }
    else if (packetBuffer[0] == '3') {
      digitalWrite(led3, HIGH);
    }
  }
}
