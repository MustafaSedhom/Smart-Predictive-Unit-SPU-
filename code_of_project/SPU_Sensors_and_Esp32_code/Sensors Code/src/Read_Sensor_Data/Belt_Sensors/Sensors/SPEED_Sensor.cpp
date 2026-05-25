#include "SPEED_Sensor.h"

Belt_Speed_Sensor* _instance = nullptr; // singleton for ISR

// Constructor
Belt_Speed_Sensor::Belt_Speed_Sensor(uint8_t pin, float wheel_circumference, float pulses_per_rev)
{
    _sensor_pin = pin;
    _pulse_count = 0;
    _wheel_circumference = wheel_circumference;
    _pulses_per_rev = pulses_per_rev;

    _instance = this; // for ISR
}

void Belt_Speed_Sensor::begin()
{
    pinMode(_sensor_pin, INPUT_PULLUP);
    attachInterrupt(digitalPinToInterrupt(_sensor_pin), []() {
        _instance->_pulse_count++;
    }, RISING);
}

void Belt_Speed_Sensor::reset()
{
    _pulse_count = 0;
}

// Read speed in m/s
float Belt_Speed_Sensor::Read()
{
    // copy pulses atomically
    noInterrupts();
    long pulses = _pulse_count;
    _pulse_count = 0;
    interrupts();

    // calculate revolutions
    float rev = pulses / _pulses_per_rev;

    // speed = distance / time
    // distance = rev * wheel circumference
    // time = 1 second (assume Read() called every 1s)
    float speed = rev * _wheel_circumference; // units per second (cm/s or m/s depending on circumference)

    return speed;
}