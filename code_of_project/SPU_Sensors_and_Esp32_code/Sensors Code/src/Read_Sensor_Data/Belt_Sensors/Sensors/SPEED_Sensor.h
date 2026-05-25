#ifndef SPEED_SENSOR_H_     
#define SPEED_SENSOR_H_
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#include <Arduino.h>
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
class Belt_Speed_Sensor
{
private:
    uint8_t _sensor_pin;
    volatile long _pulse_count;  
    float _wheel_circumference; 
    float _pulses_per_rev;      

    static void pulseISR();

public:
    Belt_Speed_Sensor(uint8_t pin, float wheel_circumference, float pulses_per_rev);

    void begin();   // attach interrupt
    float Read();   // return speed in m/s or cm/s
    void reset();   // reset pulse count
};
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#endif // !SPEED_SENSOR_H_