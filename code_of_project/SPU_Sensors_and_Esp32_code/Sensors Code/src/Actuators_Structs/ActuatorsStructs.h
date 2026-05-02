#ifndef ACTAUTORESSTRUCTS_H_
#define ACTAUTORESSTRUCTS_H_
//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// make struct of all Actuators to use it
//phase
class Phases 
{
   public:
      float Phase_R;
      float Phase_S;
      float Phase_T;
      Phases()
      {
         Phase_R =0;
         Phase_S =0;
         Phase_T =0;
      }
      Phases(float P_R,float P_S,float P_T)
      {
         Phase_R =P_R;
         Phase_S =P_S;
         Phase_T =P_T;
      }
      bool operator==(const Phases& other) const
      {
         return Phase_R == other.Phase_R &&
                  Phase_S == other.Phase_S && 
                  Phase_T == other.Phase_T;
      }

      bool operator!=(const Phases& other) const
      {
         return !(*this == other);
      }
};

// Motor
class Motor
{
   public:
      float Temperature;
      float Vibration;
      Phases Volt;
      Phases Current;
      Motor()
      {
         Temperature = 0;
         Vibration = 0 ;
         Volt = Phases() ;
         Current = Phases() ;
      }
      Motor(float temp,float vib,Phases V,Phases C)
      {
         Temperature = temp;
         Vibration = vib ;
         Volt = V ;
         Current = C ;
      }

      bool operator==(const Motor& other) const
      {
         return Temperature == other.Temperature &&
                  Vibration == other.Vibration &&
                  Volt == other.Volt &&
                  Current == other.Current;
      }

      bool operator!=(const Motor& other) const
      {
         return !(*this == other);
      }
};

// Belt Driver
class Belt
{
   public:
      float Tension;
      float Alignment;
      float Speed;
      Belt ()
      {
         Tension = 0 ;
         Alignment = 0 ;
         Speed = 0 ;
      }
      Belt (float Tens,float Ali,float speed)
      {
         Tension = Tens ;
         Alignment = Ali ;
         Speed = speed ;
      }
      bool operator==(const Belt& other) const
      {
         return Tension == other.Tension &&
                  Alignment == other.Alignment &&
                  Speed == other.Speed ;
      }
      bool operator!=(const Belt& other) const
      {
         return !(*this == other);
      }
};

// Pump
class Pump
{
   public:
      float Pressure;
      float Flow_Rate;
      float Temperature;
      Pump ()
      {
         Pressure = 0 ;
         Flow_Rate = 0 ;
         Temperature = 0 ;
      }
      Pump (float Press ,float flow ,float Temp)
      {
         Pressure = Press ;
         Flow_Rate = flow ;
         Temperature = Temp ;
      }
      bool operator==(const Pump& other) const
         {
            return Pressure == other.Pressure &&
                     Flow_Rate == other.Flow_Rate &&
                     Temperature == other.Temperature ;
         }

         bool operator!=(const Pump& other) const
         {
            return !(*this == other);
         }
};

//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#endif // !ACTAUTORESSTRUCTS_H_