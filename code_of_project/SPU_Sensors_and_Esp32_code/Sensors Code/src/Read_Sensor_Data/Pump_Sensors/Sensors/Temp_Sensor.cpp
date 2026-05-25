#include "TEMP_SENSOR.h"

//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
Pump_Temperature_Sensor::Pump_Temperature_Sensor(uint8_t Connection_Pin)
{
    _sensor_pin = Connection_Pin;

    oneWire = new OneWire(_sensor_pin);

    sensors = new DallasTemperature(oneWire);

    sensors->begin();
}
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
float Pump_Temperature_Sensor::Read()
{
    sensors->requestTemperatures();

    float temperature =
        sensors->getTempCByIndex(0);

    return temperature;
}
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB