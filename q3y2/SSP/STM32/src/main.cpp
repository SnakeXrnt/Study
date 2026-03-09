#include <Arduino.h>
#include <SPI.h>
#include <WiFiST.h>

// Mutable array for SSID (Required by this library)
char ssid[] = "Ziggo1395598";
const char* password = "d5nNgGc2byjv";

SPIClass SPI_3(PC12, PC11, PC10);
WiFiClass WiFi(&SPI_3, PE0, PE1, PE8, PB13);

void setup() {
    Serial.begin(9600);

    // CRITICAL: Give yourself 5 seconds to open the Serial Monitor
    // before the board starts doing anything.
    delay(5000); 

    Serial.println("\n\n--- BOARD RESET ---");
    Serial.println("B-L475E-IOT01A WiFi Test Initiated");

    // Check Hardware
    if (WiFi.status() == WL_NO_SHIELD) {
        Serial.println("ERROR: WiFi module not responding!");
        while (true);
    }

    Serial.print("Firmware Version: ");
    Serial.println(WiFi.firmwareVersion());

    Serial.print("Connecting to network: ");
    Serial.println(ssid);

    WiFi.begin(ssid, password);

    // Wait for connection
    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }

    Serial.println("\n\nSUCCESS: WiFi Connected!");
    Serial.println("--------------------------------");
    Serial.print("IP Address: ");
    Serial.println(WiFi.localIP());
    Serial.print("Signal Strength (RSSI): ");
    Serial.print(WiFi.RSSI());
    Serial.println(" dBm");
    Serial.println("--------------------------------");
}

void loop() {
    // 1. Visual Heartbeat (Blink)
    digitalWrite(LED_BUILTIN, HIGH);
    delay(100);
    digitalWrite(LED_BUILTIN, LOW);
    
    // 2. Serial Heartbeat (Print)
    Serial.print("Status: Alive | IP: ");
    Serial.print(WiFi.localIP());
    Serial.print(" | Time: ");
    Serial.println(millis() / 1000); // Print uptime in seconds

    delay(1000);
}
