
# Arduino (Sensors)
#         ↓
#    Serial / WiFi
#         ↓
# Python (Processing + AI Model)
#         ↓
#    JSON Output
#         ↓
# Flutter App (Dashboard)

from handling_Data import Data_from_json
import os

base_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")


Data = Data_from_json(file_path)

print(Data.Overall_Health)
print(Data.Active_alarms)
print(Data.Sensors_online)
print(Data.Next_Maintenance)
print(Data.Actuators)

