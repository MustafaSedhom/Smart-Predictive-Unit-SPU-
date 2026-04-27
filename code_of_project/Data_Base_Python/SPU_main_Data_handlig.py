
# Arduino (Sensors)
#         ↓
#    Serial / WiFi
#         ↓
# Python (Processing + AI Model)
#         ↓
#    JSON Output
#         ↓
# Flutter App (Dashboard)

import os
from datetime import datetime

from Data_Base_Manger.Data_Base_Manager import DataManager
from Alerts_Data.Alerts_Data import AlertStruct


base_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")

DataBase = DataManager(file_path)
Date_time_now = datetime.now()

if __name__ == "__main__":
    DataBase.alert.add_alert( AlertStruct(
        device="motor",
        timestamp= DataBase.time_date_handling.to_iso(Date_time_now),
        period_name=Date_time_now.strftime("%p"),
        type="current",
        message="High vibration detected",
        level="low",
        value=45,
        unit="A"
        ))
    pass
    
########################################################################