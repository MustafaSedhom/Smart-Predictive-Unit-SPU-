#include "Volt_Sensor.h"
#include <math.h>

Motor_Volt_Sensor::Motor_Volt_Sensor(uint8_t pin, float calibration)
{
    _pin = pin;
    _calibration = calibration;

    pinMode(_pin, INPUT);
}
float Motor_Volt_Sensor::Read()
{
    const int samples = 200;

    float sum = 0;

    float offset = 512; // ADC midpoint (2.5V)

    for(int i = 0; i < samples; i++)
    {
        int adc = analogRead(_pin);

        float v = adc - offset;

        sum += v * v;
    }

    float v_rms_adc = sqrt(sum / samples);

    float voltage = v_rms_adc * (5.0 / 1023.0);

    float v_real = voltage * _calibration;

    return v_real;
}