
# Arduino (Sensors)
#         ↓
#    Serial / WiFi
#         ↓
# Python (Processing + AI Model)
#         ↓
#    JSON Output
#         ↓
# Flutter App (Dashboard)

from Actuators_Data.Motor_Data import Motor_Data
from Actuators_Data.Belt_Driver_Data import Belt_Driver_Data
from Actuators_Data.Pump_Data import Pump_Data
from handling_Data.handling_Data import Control_Data_from_json
import os

base_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")


Data = Control_Data_from_json(file_path)

motor = Motor_Data(file_path)
pump = Pump_Data(file_path)
belt = Belt_Driver_Data(file_path)
# print("================================================================")
# choose_actuator = int(input("choose :\n1-> Motor\n 2-> Belt\n 3-> Pump"))
# if(choose_actuator == 1):
#     choose_actuator = int(input("choose :\n1-> \n 2-> Belt\n 3-> Pump"))
# elif(choose_actuator == 2):
#     pass
# elif(choose_actuator == 3):
#     pass
# else:
#     pass
# print("================================================================")

########################################################################
def choose_actuator():
    print("================================================================")
    print("Choose Actuator:")
    print("1 -> Motor")
    print("2 -> Belt Driver")
    print("3 -> Pump")
    print("4 -> Exit")

    choice = int(input("Enter choice: "))

    if choice == 1:
        return "Motor"
    elif choice == 2:
        return "Belt_Driver"
    elif choice == 3:
        return "Pump"
    elif choice == 4:
        return "Exit"
    else:
        print("Invalid choice")
        return None

def choose_action():
    print("\n1 -> GET value")
    print("2 -> SET value")
    return int(input("Enter: "))

def choose_key():
    print("\nChoose parameter:")
    print("1 -> Health")
    print("2 -> status")
    print("3 -> Predicted_fault")
    print("4 -> Sensors")
    return int(input("Enter: "))

def control_app_Data():
    while True:
        actuator = choose_actuator()
        if actuator == "Exit":
            break
        if actuator is None:
            print("Invalid actuator")
            return
        action = choose_action()
        # ================= GET =================
        if action == 1:
            key = choose_key()

            if key == 1:
                if(actuator == "Motor"):
                    print(motor.get_Health())
                elif(actuator == "Belt_Driver"):
                    print(belt.get_Health())
                elif(actuator == "Pump"):
                    print(pump.get_Health())

            elif key == 2:
                if(actuator == "Motor"):
                    print(motor.get_status())
                elif(actuator == "Belt_Driver"):
                    print(belt.get_status())
                elif(actuator == "Pump"):
                    print(pump.get_status())

            elif key == 3:
                if(actuator == "Motor"):
                    print(motor.get_Predicted_fault())
                elif(actuator == "Belt_Driver"):
                    print(belt.get_Predicted_fault())
                elif(actuator == "Pump"):
                    print(pump.get_Predicted_fault())

            elif key == 4:
                if(actuator == "Motor"):
                    print(motor.get_Sensors())
                elif(actuator == "Belt_Driver"):
                    print(belt.get_Sensors())
                elif(actuator == "Pump"):
                    print(pump.get_Sensors())

        # ================= SET =================
        elif action == 2:
            key = choose_key()

            if key == 1:
                value = float(input("Enter Health: "))
                if(actuator == "Motor"):
                    motor.set_Health(value)
                elif(actuator == "Belt_Driver"):
                    belt.set_Health(value)
                elif(actuator == "Pump"):
                    pump.set_Health(value)

            elif key == 2:
                value = input("Enter status: ")
                if(actuator == "Motor"):
                    motor.set_status(value)
                elif(actuator == "Belt_Driver"):
                    belt.set_status(value)
                elif(actuator == "Pump"):
                    pump.set_status(value)

            elif key == 3:
                value = float(input("Enter Predicted_fault: "))
                if(actuator == "Motor"):
                    motor.set_Predicted_fault(value)
                elif(actuator == "Belt_Driver"):
                    belt.set_Predicted_fault(value)
                elif(actuator == "Pump"):
                    pump.set_Predicted_fault(value)

            elif key == 4:
                if(actuator == "Motor"):
                    print("\nChoose type of Motor Sensor:")
                    print("1 -> Temperature")
                    print("2 -> Vibration")
                    print("3 -> Current")
                    print("4 -> Exit")
                    choose_sensor = int(input("Enter: "))
                    if choose_sensor == 1:
                        value = float(input("Enter value: "))
                        motor.set_Temperature(value)
                    elif choose_sensor == 2:
                        value = float(input("Enter value: "))
                        motor.set_Vibration(value)
                    elif choose_sensor == 3:
                        value = float(input("Enter value: "))
                        motor.set_Current(value)
                    elif choose_sensor == 4:
                        break
                elif(actuator == "Belt_Driver"):
                    print("\nChoose type of Belt Driver Sensor:")
                    print("1 -> Tension")
                    print("2 -> Alignment")
                    print("3 -> Speed")
                    print("4 -> Exit")
                    choose_sensor = int(input("Enter: "))
                    if choose_sensor == 1:
                        value = float(input("Enter value: "))
                        belt.set_Tension(value)
                    elif choose_sensor == 2:
                        value = float(input("Enter value: "))
                        belt.set_Alignment(value)
                    elif choose_sensor == 3:
                        value = float(input("Enter value: "))
                        belt.set_Speed(value)
                    elif choose_sensor == 4:
                        break
                elif(actuator == "Pump"):
                    print("\nChoose type of Pump Sensor:")
                    print("1 -> Pressure In")
                    print("2 -> Flow Rate")
                    print("3 -> Temprtautre")
                    print("4 -> Exit")
                    choose_sensor = int(input("Enter: "))
                    if choose_sensor == 1:
                        value = float(input("Enter value: "))
                        pump.set_Pressure_In(value)
                    elif choose_sensor == 2:
                        value = float(input("Enter value: "))
                        pump.set_Flow_Rate(value)
                    elif choose_sensor == 3:
                        value = float(input("Enter value: "))
                        pump.set_Temperature(value)
                    elif choose_sensor == 4:
                        break
        print("\n==============================\n")

if __name__ == "__main__":
    control_app_Data()