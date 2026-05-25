#ifndef PUMP_SENSORS_H_
#define PUMP_SENSORS_H_
//PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
#include "Sensors/Flow_Rate_Sensor.h"
#include "Sensors/Temp_Sensor.h"
//PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
class Pump_Sensors
{
    private:
    public:
        Pump_Flow_Rate_Sensor Flow_Rate;
        Pump_Temperature_Sensor Temp;
        Pump_Sensors(uint8_t flow_pin , uint8_t temp_pin)
        :
            Flow_Rate(flow_pin),
            Temp(temp_pin)
        {
            
        }
        void begin()
        {}
};

//PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP
#endif // !PUMP_SENSORS_H_