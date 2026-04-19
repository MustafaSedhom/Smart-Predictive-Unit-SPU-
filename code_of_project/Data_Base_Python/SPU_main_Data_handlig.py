
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
from handling_Data.handling_Data import Control_Data_from_json
import os

base_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")


Data = Control_Data_from_json(file_path)
motor = Motor_Data(file_path)
print("================================================================")
print(motor.get_Sensors())
print(motor.get_Temperature())
motor.set_Temperature(10)
print(motor.get_Temperature())
print("================================================================")