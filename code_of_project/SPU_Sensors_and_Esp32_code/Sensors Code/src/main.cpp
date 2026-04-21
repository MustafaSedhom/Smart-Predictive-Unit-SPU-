#include <Arduino.h>
#include "ArduinoJson.h"
void setup() 
{
  Serial.begin(9600);

  JsonDocument doc;

  doc["temperature"] = 32.5;
  doc["vibration"] = 1.2;
  doc["current"] = 1.4;

  serializeJson(doc, Serial);
  Serial.println();
}

void loop() 
{
}
