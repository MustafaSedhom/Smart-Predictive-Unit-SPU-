
import random
import time

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
    def update_last_motor_data(self):
        self.last_motor_data = Read_Last_Motor_Data(self.file_path_last_motor_data)
        self.all_motor_last_data = Read_All_Last_Data_to_One_Actuator(self.file_path_last_motor_data)
    def filter_motor_data(self):

        df = Read_All_Last_Data_to_One_Actuator(
            self.file_path_last_motor_data
        )

        df["DateTime"] = pd.to_datetime(
            df["Date"].astype(str) + " " + df["Time"].astype(str)
        )

        start_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings.get_motor_analysis_start_time()
        )

        end_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings.get_motor_analysis_end_time()
        )

        return df[
            (df["DateTime"] >= start_time) &
            (df["DateTime"] <= end_time)
        ]
    def set_status_based_on_health(self,health):
        if health < self.Data_Base.Data_Base.health_thresholds.get_motor_health_thresholds_alert():
            self.Data_Base.Data_Base.motor.set_status("alert")
        elif health < self.Data_Base.Data_Base.health_thresholds.get_motor_health_thresholds_warning():
            self.Data_Base.Data_Base.motor.set_status("warning")
        else:
            self.Data_Base.Data_Base.motor.set_status("normal") 
    def calc_motor_temperature_Health(self):

        self.update_last_motor_data()

        df = self.filter_motor_data()

        if df.empty:
            print("No data available")
            return 0

        avg_temp = self.Data_Base.Data_Base.motor.get_Temperature()

        normal = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Temperature_normal()
        max_t = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Temperature_max()

        health = 100 - ((avg_temp - normal) / (max_t - normal)) * 100

        health = max(0, min(100, health))
        return health
    def analyse_motor_data(self):
        filtered_data_after_min_max_time = self.filter_motor_data()

       
        health = self.calc_motor_temperature_Health()
        self.Data_Base.Data_Base.motor.set_Health(int(health))
        self.set_status_based_on_health(health)
