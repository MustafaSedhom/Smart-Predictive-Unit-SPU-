//-----------------------------------------------------------
// LIBRARIES
#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_ADXL345_U.h>
#include <Adafruit_Sensor.h>
#include <OneWire.h>
#include <DallasTemperature.h>
// project files
#include "Actuators_Structs/ActuatorsStructs.h"
#include "Handling_Communction_Data/Json_Data.h"
//-----------------------------------------------------------
#define Enable_Debug                   false
#define communication_speed            115200
//---------------- PINS ----------------
#define Motor_Current_P_R_sensor_pin   A3 
#define Motor_Current_P_S_sensor_pin   A6 
#define Motor_Current_P_T_sensor_pin   A7 
#define Motor_Volt_P_R_sensor_pin      A0 
#define Motor_Volt_P_S_sensor_pin      A1 
#define Motor_Volt_P_T_sensor_pin      A2 
#define Motor_temperature_pin          10
#define Pump_temperature_pin           3
#define Pump_flow_rate_sensor_pin      2
//---------------- TIMING ----------------
const unsigned long startup_delay = 1000;
const unsigned long send_interval = 1000;
//---------------- OBJECTS ----------------
OneWire motor_temp_oneWire(Motor_temperature_pin);
DallasTemperature motor_temp(&motor_temp_oneWire);
OneWire pump_temp_oneWire(Pump_temperature_pin);
DallasTemperature pump_temp(&pump_temp_oneWire);
Adafruit_ADXL345_Unified accel = Adafruit_ADXL345_Unified(12345);
///////
Json_Data Json;
Motor motor , last_motor;
Belt belt , last_belt;
Pump pump , last_pump;
OverAll overall , last_overall;
SensorProblem sensor_problem , last_sensor_problem;
//---------------- FLOW ----------------
volatile unsigned long pulseCount = 0;
const float calibrationFactor = 7.5;
float totalLiters = 0;
//---------------- VIBRATION ----------------
float sumSq = 0;
unsigned long samples = 0;
//---------------- TIMERS ----------------
unsigned long startMillis;
unsigned long lastSend = 0;
//-----------------------------------------------------------
// INTERRUPT
void pulseCounter()
{
    pulseCount++;
}
//-----------------------------------------------------------
// SENSOR FUNCTIONS
float readAnalogVoltage(uint8_t pin)
{
    return analogRead(pin) * (5.0 / 1023.0);
}
float readTemperature(DallasTemperature &sensor)
{
    sensor.requestTemperatures();
    return sensor.getTempCByIndex(0);
}
// vibration struct
struct VibrationData
{
    float ax;
    float ay;
    float az;
    float total;
    float vibration;
    float rms;
};
VibrationData readVibration()
{
    sensors_event_t event;
    accel.getEvent(&event);
    VibrationData v;
    v.ax = event.acceleration.x;
    v.ay = event.acceleration.y;
    v.az = event.acceleration.z;
    v.total = sqrt(v.ax*v.ax + v.ay*v.ay + v.az*v.az);
    v.vibration = sqrt(v.ax*v.ax + v.ay*v.ay + (v.az - 9.81)*(v.az - 9.81));
    sumSq += v.vibration * v.vibration;
    samples++;
    v.rms = sqrt(sumSq / samples);
    return v;
}
float readFlowRate()
{
    noInterrupts();
    unsigned long pulses = pulseCount;
    pulseCount = 0;
    interrupts();
    return pulses / calibrationFactor;
}
//-----------------------------------------------------------
// SETUP
void setup()
{
    delay(startup_delay);
    Serial.begin(communication_speed);
    startMillis = millis();
    motor_temp.begin();
    pump_temp.begin();
    accel.begin();
    accel.setRange(ADXL345_RANGE_16_G);
    pinMode(Pump_flow_rate_sensor_pin, INPUT_PULLUP);
    attachInterrupt(digitalPinToInterrupt(Pump_flow_rate_sensor_pin),pulseCounter,FALLING);
    motor = Motor(55,2.1,Phases(221.3,220.1,33),Phases(7.7,2.1,1.0));
    pump = Pump(18.3,22.4,55);
    belt = Belt(1122,3.5,555);
    overall = OverAll(13,9);
    sensor_problem.Clear();
    sensor_problem.Add("Motor Current Sensor P_R");
    Json.updateMotor(motor);
    Json.updatePump(pump);
    Json.updateBelt(belt);
    Json.updateOverAll(overall);
    Json.updateSensorProblem(sensor_problem);
    Serial.println("System Booting...");
    lastSend = millis();
}
//-----------------------------------------------------------
// LOOP
void loop()
{
    if (millis() - lastSend >= send_interval)
    {
        //---------------- ANALOG ----------------
        float motor_current_r = readAnalogVoltage(Motor_Current_P_R_sensor_pin);
        float motor_current_s = readAnalogVoltage(Motor_Current_P_S_sensor_pin);
        float motor_current_t = readAnalogVoltage(Motor_Current_P_T_sensor_pin);
        float motor_voltage_r = readAnalogVoltage(Motor_Volt_P_R_sensor_pin);
        float motor_voltage_s = readAnalogVoltage(Motor_Volt_P_S_sensor_pin);
        float motor_voltage_t = readAnalogVoltage(Motor_Volt_P_T_sensor_pin);
        //---------------- TEMP ----------------
        float motor_temperature = readTemperature(motor_temp);
        float pump_temperature  = readTemperature(pump_temp);
        //---------------- VIBRATION ----------------
        VibrationData vib = readVibration();
        //---------------- FLOW ----------------
        float flowRate = readFlowRate();
        totalLiters += flowRate / 60.0;
        //---------------- Assign data in classes for actuators from sensors ----------------
        motor.Current.Phase_R = motor_current_r;
        motor.Current.Phase_S = motor_current_s;
        motor.Current.Phase_T = motor_current_t;
        motor.Volt.Phase_R = motor_voltage_r;
        motor.Volt.Phase_S = motor_voltage_s;
        motor.Volt.Phase_T = motor_voltage_t;
        motor.Temperature = motor_temperature;
        motor.Vibration = vib.rms;
        pump.Temperature = pump_temperature;
        pump.Flow_Rate = flowRate;
        //---------------- debug ----------------
        if (Enable_Debug)
        {
            Serial.println("------ SENSOR DATA ------");
            Serial.print("Motor Temp: "); Serial.println(motor_temperature);
            Serial.print("Pump Temp: "); Serial.println(pump_temperature);
            Serial.print("Flow Rate: "); Serial.println(flowRate);
            Serial.print("Total L: "); Serial.println(totalLiters);
            Serial.print("Vib RMS: "); Serial.println(vib.rms);
            Serial.print("Current R: "); Serial.println(motor_current_r);
            Serial.print("Current S: "); Serial.println(motor_current_s);
            Serial.print("Current T: "); Serial.println(motor_current_t);
            Serial.print("Voltage R: "); Serial.println(motor_voltage_r);
            Serial.print("Voltage S: "); Serial.println(motor_voltage_s);
            Serial.print("Voltage T: "); Serial.println(motor_voltage_t);
            Serial.println("------------------------");
        }
        //---------------- Send data to Raspberry Pi ----------------
        if(motor != last_motor || pump != last_pump || belt != last_belt || overall != last_overall)
        {
            Json.updateAll(motor, belt, pump, overall, sensor_problem);
            Json.print_Json_formate();
            last_motor = motor;
            last_pump = pump;
            last_belt = belt;
            last_overall = overall;
        }
        //////////////////
        lastSend = millis();
    }
}