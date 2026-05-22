
from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)
from ...AI_Store_and_Read_process_Data.AI_Read_Process_Data import (
    Read_All_Last_Data_to_One_Actuator,
    Read_Last_Motor_Data,
    Read_All_Last_Health_Data
) 
from .calc_predicated_fault_of_actuator.calc_predicated_fault_of_actuator import (
    calc_Actuator_predict_fault_days,
) 
import pandas as pd
class Motor_Analysis:
    def __init__(self,DB:Access_data_Base,file_path_last_motor_data:str,file_path_last_health_data:str):
        self.Data_Base = DB
        self.file_path_last_motor_data = file_path_last_motor_data
        self.file_path_last_health_data = file_path_last_health_data
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
            self.Data_Base.Data_Base.time_date_settings.get_analysis_start_time()
        )

        end_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings.get_analysis_end_time()
        )

        return df[
            (df["DateTime"] >= start_time) &
            (df["DateTime"] <= end_time)
        ]
    def set_status_based_on_health(self,health):
        health = float(health)
        status = "normal"
        if health < self.Data_Base.Data_Base.health_thresholds.get_motor_health_thresholds_alert():
            self.Data_Base.Data_Base.motor.set_status("alert")
            status = "alert"
        elif health < self.Data_Base.Data_Base.health_thresholds.get_motor_health_thresholds_warning():
            self.Data_Base.Data_Base.motor.set_status("warning")
            status = "warning"
        else:
            self.Data_Base.Data_Base.motor.set_status("normal") 
            status = "normal"
        return status
    def calc_motor_temperature_Health(self):

        self.update_last_motor_data()

        df = self.filter_motor_data()

        if df.empty:
            print("No data available")
            return 0

        avg_temp = float(df["Temperature"].mean())

        normal = float(self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Temperature_normal())
        max_t = float(self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Temperature_max())

        health = 100 - ((avg_temp - normal) / (max_t - normal)) * 100

        health = max(0, min(100, health))
        return health
    def calc_motor_vibration_Health(self):
        self.update_last_motor_data()
        df = self.filter_motor_data()
        if df.empty:
            print("No data available")
            return 0
        avg_vibration = df["Vibration"].mean()
        normal = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Vibration_normal()
        max_v = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Vibration_max()
        health = 100 - ((avg_vibration - normal) / (max_v - normal)) * 100
        health = max(0, min(100, health))
        return health
    def calc_motor_current_Health(self):
        self.update_last_motor_data()
        df = self.filter_motor_data()
        if df.empty:
            print("No data available")
            return 0
        avg_current = df["Current_P_R"].mean()
        normal = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Current_normal()
        max_c = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Current_max()
        health = 100 - ((avg_current - normal) / (max_c - normal)) * 100
        health = max(0, min(100, health))
        return health
    def calc_motor_voltage_Health(self):
        self.update_last_motor_data()
        df = self.filter_motor_data()
        if df.empty:
            print("No data available")
            return 0
        avg_voltage = df["Volt_P_R"].mean()
        normal = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Volt_normal()
        max_v = self.Data_Base.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Volt_max()
        health = 100 - ((avg_voltage - normal) / (max_v - normal)) * 100
        health = max(0, min(100, health))
        return health
    def calc_motor_overall_Health(self):
        temp_health = self.calc_motor_temperature_Health()
        vibration_health = self.calc_motor_vibration_Health()
        current_health = self.calc_motor_current_Health()
        voltage_health = self.calc_motor_voltage_Health()

        overall_health = (temp_health + vibration_health + current_health + voltage_health) / 4
        return overall_health
    def calc_health_between_days(self):

        df = Read_All_Last_Health_Data(
            self.file_path_last_health_data
        )

        if df is None or df.empty:
            print("No Health Data")
            return None

        # Create DateTime column
        df["DateTime"] = pd.to_datetime(
            df["Date"].astype(str) + " " + df["Time"].astype(str)
        )

        # Start and End from settings
        start_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings.get_analysis_start_time()
        )

        end_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings.get_analysis_end_time()
        )

        # Filter data
        filtered_df = df[
            (df["DateTime"] >= start_time) &
            (df["DateTime"] <= end_time)
        ]

        if filtered_df.empty:
            print("No data in selected range")
            return None

        return filtered_df   
    def analyse_motor_data(self): 
        max_days_if_normal = self.Data_Base.Data_Base.max_days_if_normal.get_motor_max_days_if_normal()
        health = self.calc_motor_overall_Health()
        self.Data_Base.Data_Base.motor.set_Health(int(health))
        filtered_df = self.calc_health_between_days()
        if filtered_df is None:
            return
        health_values = filtered_df["Motor_Health"].tolist()
        days = calc_Actuator_predict_fault_days(
            health_values
        )
        status = self.set_status_based_on_health(health)
        if status == "alert" or status == "warning":
            self.Data_Base.Data_Base.motor.set_Predicted_fault(str(int(days)))
        elif status == "normal":
            self.Data_Base.Data_Base.motor.set_Predicted_fault(str(max_days_if_normal))
