#include <Arduino.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <TFT_eSPI.h>

const char* ssid = "ACSlab";
const char* password = "lab@ACS24";
const char* target_ip = "192.168.178.11";
const uint16_t port = 1234;

WiFiUDP udp;
TFT_eSPI tft = TFT_eSPI();
char packetBuffer[1400];

unsigned long bytesSent = 0;
float mbps = 0;
unsigned long lastTime = 0;

void setup() {
    Serial.begin(115200);
    tft.init();
    tft.setRotation(1);
    tft.fillScreen(TFT_BLACK);

    tft.setTextFont(4);
    tft.setTextColor(TFT_CYAN);
    tft.println("CONNECTING...");

    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) { delay(500); }

    tft.fillScreen(TFT_BLACK);
}

void loop() {
    for(int i = 0; i < 80; i++) {
        udp.beginPacket(target_ip, port);
        udp.write((const uint8_t*)packetBuffer, sizeof(packetBuffer));
        udp.endPacket();
        bytesSent += sizeof(packetBuffer);
    }

    unsigned long currentTime = millis();
    if (currentTime - lastTime >= 1000) {
        mbps = (bytesSent * 8.0) / 1000000.0;
        bytesSent = 0;
        lastTime = currentTime;

        tft.setTextWrap(false);

        tft.fillRect(0, 0, 240, 100, TFT_BLACK);

        tft.setTextColor(TFT_WHITE);
        tft.drawString("STRESS LEVEL:", 5, 5, 4);

        tft.setTextColor(TFT_GREEN);
        int xPos = 5;
        int yPos = 35;

        xPos += tft.drawFloat(mbps, 1, xPos, yPos, 6);

        tft.setTextColor(TFT_YELLOW);
        tft.drawString(" Mbps", xPos, yPos + 10, 4);

        int barWidth = map((int)mbps, 0, 50, 0, 230);
        barWidth = constrain(barWidth, 0, 230);

        tft.drawRect(5, 110, 230, 20, TFT_WHITE);
        tft.fillRect(6, 111, barWidth, 18, (mbps > 35) ? TFT_RED : TFT_BLUE);

        Serial.printf("Live Mbps: %.2f\n", mbps);
    }
    yield();
}
