#include "Flow_Rate_Sensor.h"

volatile uint32_t pulse_count = 0;

//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
void Flow_Sensor_ISR()
{
    pulse_count++;
}
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
Pump_Flow_Rate_Sensor::Pump_Flow_Rate_Sensor(uint8_t Connection_Pin)
{
    _sensor_pin = Connection_Pin;

    pinMode(_sensor_pin, INPUT_PULLUP);

    attachInterrupt(
        digitalPinToInterrupt(_sensor_pin),
        Flow_Sensor_ISR,
        RISING
    );
}
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
float Pump_Flow_Rate_Sensor::Read()
{
    static uint32_t last_time = 0;
    static uint32_t last_pulse_count = 0;

    uint32_t current_time = millis();

    // update every 1 second without blocking
    if (current_time - last_time >= 1000)
    {
        uint32_t pulses = pulse_count - last_pulse_count;

        last_pulse_count = pulse_count;
        last_time = current_time;

        /*
            YF-S201 Equation

            Flow Rate (L/min) = Frequency / 7.5
        */

        float flow_rate = pulses / 7.5;

        return flow_rate;
    }

    return -1; // no new reading yet
}
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB