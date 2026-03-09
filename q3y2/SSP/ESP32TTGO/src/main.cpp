#include <Arduino.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <TFT_eSPI.h>

const char* ssid = "Ziggo1395598";
const char* password = "d5nNgGc2byjv";
const char* target_ip = "192.168.178.11"; 
const uint16_t port = 1234;

WiFiUDP udp;
TFT_eSPI tft = TFT_eSPI();
char packetBuffer[1400]; // Optimized packet size for MTU

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
    // 1. Blast WiFi Data (Increased for more stress)
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

        // --- COORDINATE FIXES ---
        tft.setTextWrap(false); 

        // 1. Clear text areas specifically
        tft.fillRect(0, 0, 240, 100, TFT_BLACK); 

        // 2. Draw Label
        tft.setTextColor(TFT_WHITE);
        tft.drawString("STRESS LEVEL:", 5, 5, 4); // x=5, y=5, font=4

        // 3. Draw The Number (The core fix)
        // We use Font 6 (Large digits) because it's more reliable than Font 7
        tft.setTextColor(TFT_GREEN);
        int xPos = 5;
        int yPos = 35;
        
        // drawFloat returns the new X position after the number
        xPos += tft.drawFloat(mbps, 1, xPos, yPos, 6); 

        // 4. Draw the Unit right after the number
        tft.setTextColor(TFT_YELLOW);
        tft.drawString(" Mbps", xPos, yPos + 10, 4); 

        // 5. Stress Bar
        int barWidth = map((int)mbps, 0, 50, 0, 230);
        barWidth = constrain(barWidth, 0, 230);
        
        tft.drawRect(5, 110, 230, 20, TFT_WHITE); // Border
        tft.fillRect(6, 111, barWidth, 18, (mbps > 35) ? TFT_RED : TFT_BLUE);
        
        Serial.printf("Live Mbps: %.2f\n", mbps);
    }
    yield(); 
}
