// ================= VARIABLES =================
//phase
typedef struct {
  float Phase_R;
  float Phase_S;
  float Phase_T;
}Pahses;
// Motor
typedef struct{
   float Temprature;
   float Vibtation;
   Pahses Volt;
   Pahses Current;
}Motor; 
// Belt Driver
typedef struct{
   float Tension;
   float Alginment;
   float Speed;
}Belt; 
// Pump
typedef struct{
   float Pressure;
   float Flow_Rate;
   float Temprature;
}Pump; 
// objects
Motor motor;
Belt belt;
Pump pump;
// json data
String json;
// ================= SETUP =================
void setup() 
{
  Serial.begin(9600);
  // Assign values (initial values)
  motor = {
    .Temprature=1,
    .Vibtation=1.1,
    .Volt = {
      .Phase_R=1,
      .Phase_S=1,
      .Phase_T=1,
    },
    .Current = {
      .Phase_R=1.2,
      .Phase_S=1.2,
      .Phase_T=1.2,
    },
  };
  belt = {
    .Tension = 1,
    .Alginment =1.2,
    .Speed = 1.5
  };
  pump = {
    .Pressure = 1.1,
    .Flow_Rate = 1.4,
    .Temprature = 1.9
  };
  // sensd data
  String data = buildJSON(motor,belt,pump);
  Serial.print(data);
}

// ================= LOOP =================

void loop() 
{
  delay(1000);
}
// ================= FUNCTION =================
String buildJSON(Motor motor_data,Belt belt_Data,Pump pump_data) {

  String json = "{";

  json += "\"Motor\":{";
  json += "\"temperature\":" + String(motor_data.Temprature) + ",";
  json += "\"Vibration\":" + String(motor_data.Vibtation) + ",";

  json += "\"Volt\":{";
  json += "\"phase_R\":" + String(motor_data.Volt.Phase_R) + ",";
  json += "\"phase_S\":" + String(motor_data.Volt.Phase_S) + ",";
  json += "\"phase_T\":" + String(motor_data.Volt.Phase_T);
  json += "},";

  json += "\"Current\":{";
  json += "\"phase_R\":" + String(motor_data.Current.Phase_R) + ",";
  json += "\"phase_S\":" + String(motor_data.Current.Phase_S) + ",";
  json += "\"phase_T\":" + String(motor_data.Current.Phase_T);
  json += "}";

  json += "},";

  json += "\"Belt_Driver\":{";
  json += "\"Tension\":" + String(belt_Data.Tension) + ",";
  json += "\"Alignment\":" + String(belt_Data.Alginment) + ",";
  json += "\"Speed\":" + String(belt_Data.Speed);
  json += "},";

  json += "\"Pump\":{";
  json += "\"Pressure_In\":" + String(pump_data.Pressure) + ",";
  json += "\"Flow_Rate\":" + String(pump_data.Flow_Rate) + ",";
  json += "\"Temperature\":" + String(pump_data.Temprature);
  json += "}";

  json += "}";

  return json;
}









