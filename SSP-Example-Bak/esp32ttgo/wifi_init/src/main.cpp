#include <Arduino.h>
#include <WiFi.h>
#include <TFT_eSPI.h>

const char* ssid = "ACSlab";
const char* password = "lab@ACS24";

TFT_eSPI tft = TFT_eSPI();

void setup() {
    Serial.begin(115200);

    tft.init();
    tft.setRotation(1);
    tft.fillScreen(TFT_BLACK);
    tft.setTextColor(TFT_GREEN, TFT_BLACK);
    tft.setTextSize(2);

    tft.println("Connecting to:");
    tft.println(ssid);

    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
        tft.print(".");
    }

    tft.fillScreen(TFT_BLACK);
    tft.setCursor(0, 0);
    tft.println("WiFi Connected!");
    tft.println("");
    tft.setTextColor(TFT_YELLOW);
    tft.print("IP: ");
    tft.println(WiFi.localIP());

    Serial.println("\nConnected!");
    Serial.println(WiFi.localIP());
}
