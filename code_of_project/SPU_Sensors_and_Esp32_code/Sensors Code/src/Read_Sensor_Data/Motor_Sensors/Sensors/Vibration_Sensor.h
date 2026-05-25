#ifndef VIBRATION_SENSOR_H_     
#define VIBRATION_SENSOR_H_
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#include <Arduino.h>
#include <Wire.h>
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB

class Motor_Accelerometer_Sensor
{
private:
    int16_t _ax, _ay, _az;
    const uint8_t _address = 0x68;
    public:
    Motor_Accelerometer_Sensor();
    void begin();
    float Read_X();
    float Read_Y();
    float Read_Z();
};
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#endif // !VIBRATION_SENSOR_H_