#include "Vibration_Sensor.h"

Motor_Accelerometer_Sensor::Motor_Accelerometer_Sensor()
{
    Wire.begin();
}
void Motor_Accelerometer_Sensor::begin()
{
    Wire.beginTransmission(_address);
    Wire.write(0x6B); // power management
    Wire.write(0);    // wake up sensor
    Wire.endTransmission(true);
}