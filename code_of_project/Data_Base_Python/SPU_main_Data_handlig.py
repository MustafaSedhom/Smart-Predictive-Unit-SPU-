# Arduino (Sensors)
#         ↓
#    Serial / WiFi
#         ↓
# Python (Processing + AI Model)
#         ↓
#    JSON Output
#         ↓
# Flutter App (Dashboard)
from Json_handling_data import Data
import os

base_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")

Data_from_app = Data(file_path)

data = Data_from_app.Read_Data()
motor_current = data["Actuators"]["Motor"]["Sensors"]["Current"]
motor_status = data["Actuators"]["Motor"]["status"]
print(f"value ->  {type(motor_current)}   ->   {motor_current}")
print(f"value ->  {type(motor_status)}   ->   {motor_status}")


