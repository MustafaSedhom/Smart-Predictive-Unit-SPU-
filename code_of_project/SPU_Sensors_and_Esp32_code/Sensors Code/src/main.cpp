//-----------------------------------------------------------
// import librarys
#include <Arduino.h>
#include <Wire.h>
#include <MPU6050.h>
#include "Actuators_Structs/ActuatorsStructs.h"
#include "Handling_Communction_Data/Json_Data.h"
#include "Read_Sensor_Data/Motor_Sensors/Motor_Sensors.h"
#include "Read_Sensor_Data/Pump_Sensors/Pump_Sensors.h"
#include "Read_Sensor_Data/Belt_Sensors/Belt_Sensors.h"
#include "Read_Sensor_Data/Over_All_Data/Over_All_Data.h"
//-----------------------------------------------------------
//////////////////////// defines 
/////////// sensors pins
// Motors pin
#define Motor_Current_P_R_sensor_pin   A3 
#define Motor_Current_P_S_sensor_pin   A6 
#define Motor_Current_P_T_sensor_pin   A7 
#define Motor_Volt_P_R_sensor_pin      A0 
#define Motor_Volt_P_S_sensor_pin      A1 
#define Motor_Volt_P_T_sensor_pin      A2 
#define Motor_Vibration_SCL_pin        A4        // I2C protocol
#define Motor_Vibration_SDA_pin        A5        // I2C protocol
#define Motor_temperature_pin          10
// Belt pins
// #define Belt_speed_A_pin               11
// #define Belt_speed_B_pin               12
// Pump pins
#define Pump_flow_rate_sensor_pin      2         // or 3 because interrupt  
#define Pump_temperature_pin           3
/////////////////
// system
#define delay_time_to_launch          60000     // 1 minute     
#define delay_time_to_send_data       1000      // 1 second
//-----------------------------------------------------------
// sensors definitions
Pump_Sensors pump_sensor(5,6);
Motor_Sensors motor_sensor(1,2,3,4,5,6,7);
Belt_Sensors belt_sensor(12,31.4,20);
//-----------------------------------------------------------
// Global Variables
unsigned long lastSend;
Json_Data Json;
Motor motor , last_motor;
Belt belt , last_belt;
Pump pump , last_pump;
OverAll overall , last_overall;
//-----------------------------------------------------------
// init program
void setup() 
{
    delay(delay_time_to_launch);
    Serial.begin(115200);
    motor_sensor.begin();
    pump_sensor.begin();
    belt_sensor.begin();
    motor = Motor(55,2.1,Phases(221.3,220.1,33),Phases(7.7,2.1,1.0));
    pump = Pump(18.3,22.4,55);
    belt = Belt(1122,3.5,555);
    overall = OverAll(13,9);
    Json.updateMotor(motor);
    Json.updatePump(pump);
    Json.updateBelt(belt);
    Json.updateOverAll(overall);
    lastSend = millis();
}
//-----------------------------------------------------------
// program
void loop()  
{   
    // check if it's time to send data
    if (millis() - lastSend >= delay_time_to_send_data)
    {
        // check temp is not above 100 to avoid overflow
        if(motor != last_motor || pump != last_pump || belt != last_belt || overall != last_overall)
        {
            Json.updateAll(motor, belt, pump,overall);
            Serial.println(Json.get_Json_formate()); 
            last_motor = motor;
            last_pump = pump;
            last_belt = belt;
            last_overall = overall;
        }
        lastSend = millis();
    }
}
//-----------------------------------------------------------
