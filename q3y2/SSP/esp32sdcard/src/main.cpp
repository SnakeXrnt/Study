#include <Arduino.h>
#include "FS.h"
#include "SD.h"
#include "SPI.h"

// --- ADD THIS LINE HERE ---
void printDirectory(File dir, int numTabs); 

// ... the rest of your defines and setup() ...// Define pins based on your schematic
#define SD_MISO  2
#define SD_MOSI  17
#define SD_SCLK  22
#define SD_CS    21

SPIClass sdSPI(HSPI); // Create a custom SPI instance

void setup() {
  Serial.begin(115200);

  // Initialize custom SPI pins
  sdSPI.begin(SD_SCLK, SD_MISO, SD_MOSI, SD_CS);

  Serial.println("Initializing SD card...");

  // Initialize SD card with the custom SPI bus
  if (!SD.begin(SD_SCLK, sdSPI)) {
    Serial.println("Card Mount Failed! Check wiring or SD card format (FAT32).");
    return;
  }

  uint8_t cardType = SD.cardType();
  if (cardType == CARD_NONE) {
    Serial.println("No SD card attached");
    return;
  }

  Serial.println("SD Card Initialized successfully.");
  
  // Example: List files on the card
  File root = SD.open("/");
  printDirectory(root, 0);
}

void loop() {
  // Nothing here for the demo
}

void printDirectory(File dir, int numTabs) {
  while (true) {
    File entry =  dir.openNextFile();
    if (! entry) break;
    for (uint8_t i = 0; i < numTabs; i++) Serial.print('\t');
    Serial.print(entry.name());
    if (entry.isDirectory()) {
      Serial.println("/");
      printDirectory(entry, numTabs + 1);
    } else {
      Serial.print("\t\t");
      Serial.println(entry.size(), DEC);
    }
    entry.close();
  }
}
