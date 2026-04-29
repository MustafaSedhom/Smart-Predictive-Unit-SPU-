#ifndef ACTAUTORESSTRUCTS_H_
#define ACTAUTORESSTRUCTS_H_
//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// make struct of all Actuators to use it
//phase
typedef struct {
  float Phase_R;
  float Phase_S;
  float Phase_T;
}Phases;
// Motor
typedef struct{
   float Temperature;
   float Vibration;
   Phases Volt;
   Phases Current;
}Motor; 
// Belt Driver
typedef struct{
   float Tension;
   float Alignment;
   float Speed;
}Belt; 
// Pump
typedef struct{
   float Pressure;
   float Flow_Rate;
   float Temperature;
}Pump; 
//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#endif // !ACTAUTORESSTRUCTS_H_