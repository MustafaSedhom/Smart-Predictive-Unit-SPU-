#ifndef BELT_SENSORS_H_     
#define BELT_SENSORS_H_
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#include "Sensors/SPEED_Sensor.h"
//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
class Belt_Sensors
{
public:

    Belt_Speed_Sensor Speed;

    Belt_Sensors(
        uint8_t speed_pin,
        float wheel_circumference,
        float pulses_per_rev
    )
    :
        Speed(speed_pin, wheel_circumference, pulses_per_rev)
    {

    }
    void begin()
    {
        Speed.begin();
    }
};



//BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
#endif // !BELT_SENSORS_H_