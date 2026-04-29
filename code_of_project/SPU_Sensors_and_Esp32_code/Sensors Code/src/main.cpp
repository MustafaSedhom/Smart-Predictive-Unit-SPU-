//-----------------------------------------------------------
// import librarys
#include <Arduino.h>
#include "Actuators_Structs/ActuatorsStructs.h"
#include "Handling_Communction_Data/Json_Data.h"
//-----------------------------------------------------------
// defines 

//-----------------------------------------------------------
// Global Variables
Motor motor;
Belt belt;
Pump pump;
Json_Data Json;
//-----------------------------------------------------------
// init program
void setup() 
{
    Serial.begin(9600);
}
//-----------------------------------------------------------
// program
void loop()  
{   
}
//-----------------------------------------------------------
