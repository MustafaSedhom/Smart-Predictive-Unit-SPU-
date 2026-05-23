//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
#include "Json_Data.h"
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
// define functions
void Json_Data::updateAll(const Motor& motor_data,
                    const Belt& belt_data,
                    const Pump& pump_data,
                    const OverAll& overall_data)
{
    _motor = motor_data;
    _belt = belt_data;
    _pump = pump_data;
    _overall = overall_data ;
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
void Json_Data::convert_to_json_formate()
{
     // ================= start json formate =================
    _json_formate = "{";
    // ================= MOTOR =================
    _json_formate += "\"Motor\":{";
    _json_formate += "\"temperature\":" + String(_motor.Temperature) + ",";
    _json_formate += "\"Vibration\":" + String(_motor.Vibration) + ",";

    _json_formate += "\"Volt\":{";
    _json_formate += "\"phase_R\":" + String(_motor.Volt.Phase_R) + ",";
    _json_formate += "\"phase_S\":" + String(_motor.Volt.Phase_S) + ",";
    _json_formate += "\"phase_T\":" + String(_motor.Volt.Phase_T);
    _json_formate += "},";

    _json_formate += "\"Current\":{";
    _json_formate += "\"phase_R\":" + String(_motor.Current.Phase_R) + ",";
    _json_formate += "\"phase_S\":" + String(_motor.Current.Phase_S) + ",";
    _json_formate += "\"phase_T\":" + String(_motor.Current.Phase_T);
    _json_formate += "}";

    _json_formate += "},";

    // ================= BELT =================
    _json_formate += "\"Belt_Driver\":{";
    _json_formate += "\"Tension\":" + String(_belt.Tension) + ",";
    _json_formate += "\"Alignment\":" + String(_belt.Alignment) + ",";
    _json_formate += "\"Speed\":" + String(_belt.Speed);
    _json_formate += "},";

    // ================= PUMP =================
    _json_formate += "\"Pump\":{";
    _json_formate += "\"Pressure_In\":" + String(_pump.Pressure) + ",";
    _json_formate += "\"Flow_Rate\":" + String(_pump.Flow_Rate) + ",";
    _json_formate += "\"Temperature\":" + String(_pump.Temperature);
    _json_formate += "},";

    // ================= OVERALL =================
    _json_formate += "\"Over_All\":{";
    _json_formate += "\"Sensors_Count\":" + String(_overall.Sensors_Count) + ",";
    _json_formate += "\"Sensors_Online\":" + String(_overall.Sensors_Online);
    _json_formate += "}";
    
    // ================= end json formate =================
    _json_formate += "}";
}
String Json_Data::get_Json_formate()
{
    convert_to_json_formate();
    return _json_formate;
}
//JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ



