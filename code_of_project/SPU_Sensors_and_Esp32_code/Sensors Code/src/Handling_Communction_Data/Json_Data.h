#ifndef JSON_DATA_H_
#define JSON_DATA_H_
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
#include <Arduino.h>
#include "Actuators_Structs/ActuatorsStructs.h"
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
class Json_Data
{
    private:
        AC_Motor _ac_motor;
        DC_Motor _dc_motor;
        Belt _belt;
        OverAll _overall;
        SensorProblem _sensor_problem;
        void convert_to_json_formate();
    public:
        void updateAll(
                    const AC_Motor& motor_data,
                    const Belt& belt_data,
                    const DC_Motor& pump_data,
                    const OverAll& overall_data,
                    const SensorProblem& sensor_problem
            );
        void updateMotor(const AC_Motor& motor_data);
        void updateBelt(const Belt& belt_data);
        void updatePump(const DC_Motor& pump_data);
        void updateOverAll(const OverAll& overall_data);
        void updateSensorProblem(const SensorProblem& sensor_problem);
        void print_Json_formate();
};
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
#endif // !JSON_DATA_H_