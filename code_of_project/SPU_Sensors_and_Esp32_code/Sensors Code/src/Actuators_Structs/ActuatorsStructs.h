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
class AC_Motor
{
   public:
      float Temperature;
      float Vibration;
      Phases Volt;
      Phases Current;
      AC_Motor()
      {
         Temperature = 0;
         Vibration = 0 ;
         Volt = Phases() ;
         Current = Phases() ;
      }
      AC_Motor(float temp,float vib,Phases V,Phases C)
      {
         Temperature = temp;
         Vibration = vib ;
         Volt = V ;
         Current = C ;
      }

      bool operator==(const AC_Motor& other) const
      {
         return Temperature == other.Temperature &&
                  Vibration == other.Vibration &&
                  Volt == other.Volt &&
                  Current == other.Current;
      }

      bool operator!=(const AC_Motor& other) const
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

// DC_Motor
class DC_Motor
{
   public:
      float Volt;
      float Current;
      float Vibration;
      DC_Motor ()
      {
         Volt = 0 ;
         Current = 0 ;
         Vibration = 0 ;
      }
      DC_Motor (float volt ,float current ,float vib)
      {
        Volt = volt;
        Current = current;
        Vibration = vib;
      }
      bool operator==(const DC_Motor& other) const
         {
            return Volt == other.Volt &&
                     Current == other.Current &&
                     Vibration == other.Vibration ;
         }

         bool operator!=(const DC_Motor& other) const
         {
            return !(*this == other);
         }
};
//overall data
class OverAll
{
   public:
      int Sensors_Count;
      int Sensors_Online;
      OverAll()
      {
         Sensors_Count = 0 ;
         Sensors_Online = 0 ;
      }
      OverAll(int sensors_count,int sensors_online)
      {
         Sensors_Count = sensors_count;
         Sensors_Online = sensors_online;
      }
      bool operator==(const OverAll& other) const
         {
            return Sensors_Count == other.Sensors_Count &&
                     Sensors_Online == other.Sensors_Online ;
         }

         bool operator!=(const OverAll& other) const
         {
            return !(*this == other);
         }
};
class SensorProblem
{
public:
    String List[10];
    int Count = 0;

    void Add(String Name)
    {
        List[Count++] = Name;
    }
    void Clear()
    {
        Count = 0;
    }
};

//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
#endif // !ACTAUTORESSTRUCTS_H_