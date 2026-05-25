#include <math.h>
#include "Current_Sensors.h"

Motor_Current_Sensors::Motor_Current_Sensors(uint8_t pin, float calibration)
{
    _sensor_pin = pin;
    _calibration = calibration;

    pinMode(_sensor_pin, INPUT);
}

float Motor_Current_Sensors::Read()
{
    const int samples = 200;

    float sum = 0;

    for(int i = 0; i < samples; i++)
    {
        int adc = analogRead(_sensor_pin);

        float voltage = adc * (5.0 / 1023.0);

        sum += voltage * voltage;
    }

    float v_rms = sqrt(sum / samples);

    float current = v_rms * _calibration;

    return current;
}