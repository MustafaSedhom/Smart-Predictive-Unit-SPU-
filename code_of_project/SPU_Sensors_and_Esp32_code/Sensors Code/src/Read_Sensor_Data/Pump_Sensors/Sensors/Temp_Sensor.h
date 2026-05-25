#ifndef TEMP_SENSOR_H_     
#define TEMP_SENSOR_H_
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#include <Arduino.h>
#include "OneWire.h"
#include "DallasTemperature.h"
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
class Pump_Temperature_Sensor
{
    private:
        uint8_t _sensor_pin;
        OneWire* oneWire;
        DallasTemperature* sensors;
    public:
        Pump_Temperature_Sensor(uint8_t Connection_Pin);
        float Read();
};
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#endif // !TEMP_SENSOR_H_