#include <Arduino.h>
#include <TFT_eSPI.h>

TFT_eSPI tft = TFT_eSPI();

#ifdef __cplusplus
extern "C" {
#endif
uint8_t temprature_sens_read();
#ifdef __cplusplus
}
#endif

void stressTask(void * pvParameters) {
        while(true) {
        volatile double x = 1.2345;
        for(int i=0; i<1000; i++) { x = sqrt(x * i); }
        vTaskDelay(1);
    }
}

void setup() {
    Serial.begin(115200);
    tft.init();
    tft.setRotation(1);
    tft.fillScreen(TFT_RED);

    xTaskCreatePinnedToCore(stressTask, "Stress", 10000, NULL, 1, NULL, 0);
}

void loop() {
    tft.setCursor(0, 0);
    tft.setTextColor(TFT_WHITE, TFT_BLACK);
    tft.setTextSize(2);

    float temp_c = (temprature_sens_read() - 32) / 1.8;
    tft.printf("Chip Temp: %.2f C\n", temp_c);

    for(int i=0; i<100; i++) {
        tft.drawRect(random(240), random(135), 20, 20, random(0xFFFF));
    }
    Serial.printf("Temp: %.2f C | Heap: %d\n", temp_c, ESP.getFreeHeap());
}
