#ifndef MOTOR_SENSORS_H_
#define MOTOR_SENSORS_H_
//TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
#include "Sensors/Current_Sensors.h"
#include "Sensors/Vibration_Sensor.h"
#include "Sensors/Volt_Sensor.h"
#include "../Pump_Sensors/Sensors/Temp_Sensor.h"
//TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
class Motor_Sensors
{
public:

    Motor_Current_Sensors Current_P_R;
    Motor_Current_Sensors Current_P_S;
    Motor_Current_Sensors Current_P_T;

    Motor_Volt_Sensor Volt_P_R;
    Motor_Volt_Sensor Volt_P_S;
    Motor_Volt_Sensor Volt_P_T;

    Motor_Accelerometer_Sensor vibration;
    Pump_Temperature_Sensor temp;

    Motor_Sensors(
        uint8_t current_pin_R,
        uint8_t current_pin_S,
        uint8_t current_pin_T,
        uint8_t volt_pin_R,
        uint8_t volt_pin_S,
        uint8_t volt_pin_T,
        uint8_t temp_pin
    )
    :
        Current_P_R(current_pin_R),
        Current_P_S(current_pin_S),
        Current_P_T(current_pin_T),

        Volt_P_R(volt_pin_R),
        Volt_P_S(volt_pin_S),
        Volt_P_T(volt_pin_T),

        vibration(),
        temp(temp_pin)
    {
    }

    void begin()
    {
        vibration.begin();
    }
};

//TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
#endif // !MOTOR_SENSORS_H_