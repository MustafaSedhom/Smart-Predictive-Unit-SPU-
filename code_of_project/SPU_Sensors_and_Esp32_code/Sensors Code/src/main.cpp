//-----------------------------------------------------------
// import librarys
#include <Arduino.h>
#include "Actuators_Structs/ActuatorsStructs.h"
#include "Handling_Communction_Data/Json_Data.h"
//-----------------------------------------------------------
// defines 
#define delay_time 1000
//-----------------------------------------------------------
// Global Variables
unsigned long lastSend;
Json_Data Json;
Motor motor , last_motor;
Belt belt , last_belt;
Pump pump , last_pump;
//-----------------------------------------------------------
// init program
void setup() 
{
    Serial.begin(115200);
    motor = Motor(98,2.1,Phases(221.3,220.1,33),Phases(7.7,2.1,1.0));
    pump = Pump(18.3,22.4,55);
    belt = Belt(1122,3.5,555);
    Json.updateMotor(motor);
    Json.updatePump(pump);
    Json.updateBelt(belt);
    lastSend = millis();
}
//-----------------------------------------------------------
// program
void loop()  
{   
    // check if it's time to send data
    if (millis() - lastSend >= delay_time)
    {
        // check temp is not above 100 to avoid overflow
        if (motor.Temperature > 100) motor.Temperature = 0;
        if (pump.Temperature > 100) pump.Temperature = 0;
        if(motor != last_motor || pump != last_pump || belt != last_belt)
        {
            Json.updateAll(motor, belt, pump);
            Serial.println(Json.get_Json_formate()); 
            last_motor = motor;
            last_pump = pump;
            last_belt = belt;
        }
        lastSend = millis();
    }
}
//-----------------------------------------------------------
