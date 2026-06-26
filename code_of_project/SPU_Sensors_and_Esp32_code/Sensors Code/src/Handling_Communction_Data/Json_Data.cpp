//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
#include "Json_Data.h"
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
// define functions
void Json_Data::updateAll(const AC_Motor& ac_motor_data,
                    const Belt& belt_data,
                    const DC_Motor& dc_motor_data,
                    const OverAll& overall_data,
                    const SensorProblem& sensor_problem)
{
    _ac_motor = ac_motor_data;
    _belt = belt_data;
    _dc_motor = dc_motor_data;
    _overall = overall_data ;
    _sensor_problem = sensor_problem ;
}
void Json_Data::updateMotor(const AC_Motor& ac_motor_data)
{
_ac_motor = ac_motor_data;
}
void Json_Data::updateBelt(const Belt& belt_data)
{
_belt = belt_data;
}
void Json_Data::updatePump(const DC_Motor& dc_motor_data)
{
_dc_motor = dc_motor_data;
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
    Serial.print("\"AC_Motor\":{");
    Serial.print("\"temperature\":");
    Serial.print(_ac_motor.Temperature);

    Serial.print(",\"Vibration\":");
    Serial.print(_ac_motor.Vibration);

    Serial.print(",\"Volt\":{");
    Serial.print("\"phase_R\":");
    Serial.print(_ac_motor.Volt.Phase_R);

    Serial.print(",\"phase_S\":");
    Serial.print(_ac_motor.Volt.Phase_S);

    Serial.print(",\"phase_T\":");
    Serial.print(_ac_motor.Volt.Phase_T);
    Serial.print("}");

    Serial.print(",\"Current\":{");
    Serial.print("\"phase_R\":");
    Serial.print(_ac_motor.Current.Phase_R);

    Serial.print(",\"phase_S\":");
    Serial.print(_ac_motor.Current.Phase_S);

    Serial.print(",\"phase_T\":");
    Serial.print(_ac_motor.Current.Phase_T);
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
    Serial.print(",\"DC_Motor\":{");
    Serial.print("\"Volt\":");
    Serial.print(_dc_motor.Volt);

    Serial.print(",\"Current\":");
    Serial.print(_dc_motor.Current);

    Serial.print(",\"Vibration\":");
    Serial.print(_dc_motor.Vibration);
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

    Serial.println("}");
}
void Json_Data::print_Json_formate()
{
    convert_to_json_formate();
}
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ



