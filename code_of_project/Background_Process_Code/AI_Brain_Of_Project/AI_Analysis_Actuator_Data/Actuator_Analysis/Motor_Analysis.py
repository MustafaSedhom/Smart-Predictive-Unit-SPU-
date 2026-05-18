
from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)
from ...AI_Store_and_Read_process_Data.AI_Read_Process_Data import (
    Read_All_Last_Data_to_One_Actuator,
    Read_Last_Motor_Data
)  
import pandas as pd
class Motor_Analysis:
    def __init__(self,DB:Access_data_Base,file_path_last_motor_data:str):
        self.Data_Base = DB
        self.file_path_last_motor_data = file_path_last_motor_data
        self.last_motor_data = Read_Last_Motor_Data(file_path_last_motor_data)
        self.all_motor_last_data = Read_All_Last_Data_to_One_Actuator(file_path_last_motor_data)

    def analyse_motor_data(self):
        df = self.all_motor_last_data
        df["DateTime"] = pd.to_datetime(
            df["Date"].astype(str) + " " + df["Time"].astype(str)
        )
        start_time = pd.to_datetime(self.Data_Base.Data_Base.time_date_settings.get_motor_analysis_start_time())
        end_time = pd.to_datetime(self.Data_Base.Data_Base.time_date_settings.get_motor_analysis_end_time())
        filtered_data_after_min_max_time = df[
            (df["DateTime"] >= start_time) &
            (df["DateTime"] <= end_time)
        ]

        print("Filtered Data:")
        print(filtered_data_after_min_max_time)
