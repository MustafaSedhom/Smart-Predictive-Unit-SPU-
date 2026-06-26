//-----------------------------------------------------------
// LIBRARIES
#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_ADXL345_U.h>
#include <Adafruit_Sensor.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <Adafruit_ADS1X15.h>

// project files
#include "Actuators_Structs/ActuatorsStructs.h"
#include "Handling_Communction_Data/Json_Data.h"

//-----------------------------------------------------------
#define communication_speed            115200

//---------------- PINS ----------------
// AC_Motor Analog Pins
#define AC_Motor_Current_P_R_sensor_pin   A3 
#define AC_Motor_Current_P_S_sensor_pin   A6 
#define AC_Motor_Current_P_T_sensor_pin   A7 
#define AC_Motor_Volt_P_R_sensor_pin      A0 
#define AC_Motor_Volt_P_S_sensor_pin      A1 
#define AC_Motor_Volt_P_T_sensor_pin      A2 
#define AC_Motor_temperature_pin          10

// DC_Motor (ADS1115 Channels)
#define DC_Motor_Current_ch   0 
#define DC_Motor_Volt_ch      1 

//---------------- TIMING ----------------
const unsigned long startup_delay = 1000;
const unsigned long send_interval = 1000;

//---------------- OBJECTS ----------------
OneWire AC_motor_temp_oneWire(AC_Motor_temperature_pin);
DallasTemperature AC_motor_temp(&AC_motor_temp_oneWire);

Adafruit_ADXL345_Unified AC_motor_accel = Adafruit_ADXL345_Unified(12345);
Adafruit_ADXL345_Unified DC_motor_accel = Adafruit_ADXL345_Unified(67890);
Adafruit_ADS1115 ads;

Json_Data Json;
AC_Motor ac_motor, last_ac_motor;
Belt belt, last_belt;
DC_Motor dc_motor, last_dc_motor;
OverAll overall, last_overall;
SensorProblem sensor_problem, last_sensor_problem;

// Connection Status Flags
bool ac_accel_connected = false;
bool dc_accel_connected = false;
bool ads_connected = false;

//---------------- TIMERS ----------------
unsigned long lastSend = 0;

//-----------------------------------------------------------
// SENSOR FUNCTIONS WITH HARDWARE VALIDATION

// Reads analog pin and screens out unstable floating values
float readAnalogVoltage(uint8_t pin, bool &is_valid)
{
    int raw = analogRead(pin);
    
    // If nothing is connected, internal floating voltage will fluctuate.
    // Real sensor circuits typically hold a steady reference when active.
    // For open-circuit detection, we check if raw data falls into unstable noise.
    if (raw <= 1 || raw >= 1022) { 
        is_valid = false;
        return -1.0;
    }
    
    is_valid = true;
    return raw * (5.0 / 1023.0);
}

// Validates OneWire bus temperature presence
float readTemperature(DallasTemperature &sensor, bool &is_valid)
{
    sensor.requestTemperatures();
    float temp = sensor.getTempCByIndex(0);
    
    if (temp == DEVICE_DISCONNECTED_C || temp == -127.0) {
        is_valid = false;
        return -1.0; 
    }
    
    is_valid = true;
    return temp;
}

// Validates I2C Accelerometer and computes dynamic RMS
float getVibrationRMS(Adafruit_ADXL345_Unified &accel, bool isConnected)
{
    if (!isConnected) return -1.0; 
    
    float sumSq = 0;
    const int sample_size = 20; 
    
    for(int i = 0; i < sample_size; i++)
    {
        sensors_event_t event;
        if (!accel.getEvent(&event)) {
            return -1.0; 
        }
        
        float ax = event.acceleration.x;
        float ay = event.acceleration.y;
        float az = event.acceleration.z;
        
        float vibration = sqrt(ax*ax + ay*ay + (az - 9.81)*(az - 9.81));
        sumSq += vibration * vibration;
        delay(1); 
    }
    
    return sqrt(sumSq / sample_size);
}

// Safely reads ADS1115 over active I2C bus channel
float readSafeADS(uint8_t channel, bool isAdsConnected)
{
    if (!isAdsConnected) return -1.0;
    int16_t raw = ads.readADC_SingleEnded(channel);
    return raw * 0.0001875;
}

//-----------------------------------------------------------
// SETUP
void setup()
{
    delay(startup_delay);
    Serial.begin(communication_speed);
    
    AC_motor_temp.begin();
    
    // Initial hardware connection handshakes
    if (AC_motor_accel.begin(0x53)) {
        ac_accel_connected = true;
        AC_motor_accel.setRange(ADXL345_RANGE_16_G);
    }
    
    if (DC_motor_accel.begin(0x1D)) {
        dc_accel_connected = true;
        DC_motor_accel.setRange(ADXL345_RANGE_16_G);
    }
    
    if (ads.begin()) {
        ads_connected = true;
    }
    
    // Initialize default safe variables
    ac_motor = AC_Motor(0, 0, Phases(0,0,0), Phases(0,0,0));
    dc_motor = DC_Motor(0, 0, 0);
    belt = Belt(0, 0, 0);
    overall = OverAll(11, 0);
    
    sensor_problem.Clear();
    Json.updateAll(ac_motor, belt, dc_motor, overall, sensor_problem);
    
    Serial.println("System Booting Complete...");
    lastSend = millis();
}

//-----------------------------------------------------------
// LOOP
void loop()
{
    if (millis() - lastSend >= send_interval)
    {
        int total_monitored_sensors = 11; // 6 Analog + 1 Temp + 2 I2C Accel + 2 ADS channels
        int connection_failed_count = 0;
        bool pin_valid = false;
        
        sensor_problem.Clear(); 

        //---------------- AC MOTOR CURRENT READINGS ----------------
        ac_motor.Current.Phase_R = readAnalogVoltage(AC_Motor_Current_P_R_sensor_pin, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Current R"); connection_failed_count++; }
        
        ac_motor.Current.Phase_S = readAnalogVoltage(AC_Motor_Current_P_S_sensor_pin, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Current S"); connection_failed_count++; }
        
        ac_motor.Current.Phase_T = readAnalogVoltage(AC_Motor_Current_P_T_sensor_pin, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Current T"); connection_failed_count++; }
        
        //---------------- AC MOTOR VOLTAGE READINGS ----------------
        ac_motor.Volt.Phase_R = readAnalogVoltage(AC_Motor_Volt_P_R_sensor_pin, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Volt R"); connection_failed_count++; }
        
        ac_motor.Volt.Phase_S = readAnalogVoltage(AC_Motor_Volt_P_S_sensor_pin, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Volt S"); connection_failed_count++; }
        
        ac_motor.Volt.Phase_T = readAnalogVoltage(AC_Motor_Volt_P_T_sensor_pin, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Volt T"); connection_failed_count++; }
        
        //---------------- AC TEMPERATURE & VIBRATION ----------------
        ac_motor.Temperature = readTemperature(AC_motor_temp, pin_valid);
        if(!pin_valid) { sensor_problem.Add("AC Temp Sensor"); connection_failed_count++; }
        
        ac_motor.Vibration = getVibrationRMS(AC_motor_accel, ac_accel_connected);
        if(ac_motor.Vibration == -1.0) { sensor_problem.Add("AC Vibration"); connection_failed_count++; }

        //---------------- I2C ACTIVE BUS CHECK ----------------
        Wire.beginTransmission(0x48); 
        ads_connected = (Wire.endTransmission() == 0);
        
        Wire.beginTransmission(0x1D); 
        dc_accel_connected = (Wire.endTransmission() == 0);

        //---------------- DC MOTOR CURRENT (ACS712) ----------------
        float dc_current_volt = readSafeADS(DC_Motor_Current_ch, ads_connected);
        if(dc_current_volt == -1.0) {
            sensor_problem.Add("DC Current (ADS)");
            connection_failed_count++;
            dc_motor.Current = -1.0;
        } else {
            float sensitivity = 0.185; 
            dc_motor.Current = (dc_current_volt - 2.5) / sensitivity;
            if (dc_motor.Current < 0.1 && dc_motor.Current > -0.1) {
                dc_motor.Current = 0.0;
            }
        }
        
        //---------------- DC MOTOR VOLTAGE (0-25V) ----------------
        float dc_voltage_volt = readSafeADS(DC_Motor_Volt_ch, ads_connected);
        if(dc_voltage_volt == -1.0) {
            sensor_problem.Add("DC Voltage (ADS)");
            connection_failed_count++;
            dc_motor.Volt = -1.0;
        } else {
            dc_motor.Volt = dc_voltage_volt * 5.0; 
        }
        
        //---------------- DC MOTOR VIBRATION ----------------
        dc_motor.Vibration = getVibrationRMS(DC_motor_accel, dc_accel_connected);
        if(dc_motor.Vibration == -1.0) { sensor_problem.Add("DC Vibration"); connection_failed_count++; }

        //---------------- BELT READINGS (SIMULATED DATA) ----------------
        belt.Alignment = random(10.0, 90.0);
        belt.Speed     = random(10.0, 90.0);
        belt.Tension   = random(10.0, 90.0);

        //---------------- OVERALL DIAGNOSTICS UPDATE ----------------
        int working_sensors = total_monitored_sensors - connection_failed_count;
        overall = OverAll(total_monitored_sensors, working_sensors);

        //---------------- JSON TRANSMISSION TO RASPBERRY PI ----------------
        Json.updateAll(ac_motor, belt, dc_motor, overall, sensor_problem);
        Json.print_Json_formate();
        
        last_ac_motor = ac_motor;
        last_dc_motor = dc_motor;
        last_belt     = belt;
        last_overall  = overall;
        
        lastSend = millis();
    }
}