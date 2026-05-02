//-----------------------------------------------------------
// import librarys
#include <Arduino.h>
#include "Actuators_Structs/ActuatorsStructs.h"
#include "Handling_Communction_Data/Json_Data.h"
//-----------------------------------------------------------
// defines 

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
    motor = Motor(45,2.1,Phases(221.3,220.1,33),Phases(5.6,2.1,1.0));
    pump = Pump(18.3,22.4,78);
    belt = Belt(5678,3.5,222);
    Json.updateMotor(motor);
    Json.updatePump(pump);
    Json.updateBelt(belt);
}
//-----------------------------------------------------------
// program
void loop()  
{   
    if (millis() - lastSend > 1000)
    {
        if(motor != last_motor || pump != last_pump || belt != last_belt)
        {
            Serial.println(Json.get_Json_formate()); 
            last_motor = motor;
            last_pump = pump;
            last_belt = belt;
        }
        lastSend = millis();
    }
}
//-----------------------------------------------------------
