//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
#include "Json_Data.h"
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
// define functions
void Json_Data::updateAll(const Motor& motor_data,
                    const Belt& belt_data,
                    const Pump& pump_data,
                    const OverAll& overall_data,
                    const SensorProblem& sensor_problem)
{
    _motor = motor_data;
    _belt = belt_data;
    _pump = pump_data;
    _overall = overall_data ;
    _sensor_problem = sensor_problem ;
}
void Json_Data::updateMotor(const Motor& motor_data)
{
_motor = motor_data;
}
void Json_Data::updateBelt(const Belt& belt_data)
{
_belt = belt_data;
}
void Json_Data::updatePump(const Pump& pump_data)
{
_pump = pump_data;
}
void Json_Data::updateOverAll(const OverAll& overall_data)
{
_overall = overall_data;
}
void Json_Data::updateSensorProblem(const SensorProblem& sensor_problem)
{
    _sensor_problem = sensor_problem;
}
void Json_Data::convert_to_json_formate()
{
    Serial.print("{");

    // ================= MOTOR =================
    Serial.print("\"Motor\":{");
    Serial.print("\"temperature\":");
    Serial.print(_motor.Temperature);

    Serial.print(",\"Vibration\":");
    Serial.print(_motor.Vibration);

    Serial.print(",\"Volt\":{");
    Serial.print("\"phase_R\":");
    Serial.print(_motor.Volt.Phase_R);

    Serial.print(",\"phase_S\":");
    Serial.print(_motor.Volt.Phase_S);

    Serial.print(",\"phase_T\":");
    Serial.print(_motor.Volt.Phase_T);
    Serial.print("}");

    Serial.print(",\"Current\":{");
    Serial.print("\"phase_R\":");
    Serial.print(_motor.Current.Phase_R);

    Serial.print(",\"phase_S\":");
    Serial.print(_motor.Current.Phase_S);

    Serial.print(",\"phase_T\":");
    Serial.print(_motor.Current.Phase_T);
    Serial.print("}");

    Serial.print("}");

    // ================= BELT =================
    Serial.print(",\"Belt_Driver\":{");
    Serial.print("\"Tension\":");
    Serial.print(_belt.Tension);

    Serial.print(",\"Alignment\":");
    Serial.print(_belt.Alignment);

    Serial.print(",\"Speed\":");
    Serial.print(_belt.Speed);
    Serial.print("}");

    // ================= PUMP =================
    Serial.print(",\"Pump\":{");
    Serial.print("\"Pressure_In\":");
    Serial.print(_pump.Pressure);

    Serial.print(",\"Flow_Rate\":");
    Serial.print(_pump.Flow_Rate);

    Serial.print(",\"Temperature\":");
    Serial.print(_pump.Temperature);
    Serial.print("}");

    // ================= OVERALL =================
    Serial.print(",\"Over_All\":{");
    Serial.print("\"Sensors_Count\":");
    Serial.print(_overall.Sensors_Count);

    Serial.print(",\"Sensors_Online\":");
    Serial.print(_overall.Sensors_Online);
    Serial.print("}");

    // ================= SENSORS =================
    Serial.print(",\"Sensors\":{\"Sensor_Problem_List\":[");

    for(int i = 0; i < _sensor_problem.Count; i++)
    {
        Serial.print("\"");
        Serial.print(_sensor_problem.List[i]);
        Serial.print("\"");

        if(i < _sensor_problem.Count - 1)
        {
            Serial.print(",");
        }
    }

    Serial.print("]}");

    Serial.print("}");
}
void Json_Data::print_Json_formate()
{
    convert_to_json_formate();
}
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ



