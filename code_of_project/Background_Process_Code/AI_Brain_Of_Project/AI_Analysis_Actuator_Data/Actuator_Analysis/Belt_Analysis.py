
from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)
from ...AI_Store_and_Read_process_Data.AI_Read_Process_Data import (
    Read_All_Last_Data_to_One_Actuator,
    Read_Last_Belt_Data,
    Read_All_Last_Health_Data
)  
import pandas as pd
class Belt_Analysis:
    def __init__(self,DB:Access_data_Base,file_path_last_belt_data:str,file_path_last_health_data:str):
        self.Data_Base = DB
        self.file_path_last_belt_data = file_path_last_belt_data
        self.file_path_last_health_data = file_path_last_health_data
        self.last_belt_data = Read_Last_Belt_Data(self.file_path_last_belt_data)
        self.all_belt_last_data = Read_All_Last_Data_to_One_Actuator(self.file_path_last_belt_data)
    def update_last_belt_data(self):
        self.last_belt_data = Read_Last_Belt_Data(self.file_path_last_belt_data)
        self.all_belt_last_data = Read_All_Last_Data_to_One_Actuator(self.file_path_last_belt_data)
    def filter_belt_data(self):

        df = Read_All_Last_Data_to_One_Actuator(
            self.file_path_last_belt_data
        )

        # Convert Date + Time to DateTime
        df["DateTime"] = pd.to_datetime(
            df["Date"].astype(str) + " " + df["Time"].astype(str),
            errors="coerce"
        )

        # Convert numeric columns
        numeric_cols = [
            "Tension",
            "Alignment",
            "Speed",
            "Belt_Health"
        ]

        for col in numeric_cols:

            # if column exists
            if col in df.columns:

                df[col] = pd.to_numeric(
                    df[col],
                    errors="coerce"
                )

        # Remove invalid rows
        df = df.dropna()

        start_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings
            .get_analysis_start_time()
        )

        end_time = pd.to_datetime(
            self.Data_Base.Data_Base.time_date_settings
            .get_analysis_end_time()
        )

        filtered_df = df[
            (df["DateTime"] >= start_time) &
            (df["DateTime"] <= end_time)
        ]

        return filtered_df
    def set_status_based_on_health(self,health):
        status = "normal"
        if health < self.Data_Base.Data_Base.health_thresholds.get_belt_driver_health_thresholds_alert():
            self.Data_Base.Data_Base.belt.set_status("alert")
            status = "alert"
        elif health < self.Data_Base.Data_Base.health_thresholds.get_belt_driver_health_thresholds_warning():
            self.Data_Base.Data_Base.belt.set_status("warning")
            status = "warning"
        else:
            self.Data_Base.Data_Base.belt.set_status("normal") 
            status = "normal"
        return status
    def calc_belt_Tension_Health(self):

        self.update_last_belt_data()

        df = self.filter_belt_data()

        if df.empty:
            print("No data available")
            return 0

        avg_tension = df["Tension"].mean()

        normal = self.Data_Base.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Tension_normal()
        max_t = self.Data_Base.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Tension_max()

        health = 100 - ((avg_tension - normal) / (max_t - normal)) * 100

        health = max(0, min(100, health))
        return health
    def calc_belt_Alignment_Health(self):

        self.update_last_belt_data()

        df = self.filter_belt_data()

        if df.empty:
            print("No data available")
            return 0

        # convert column to numeric
        df["Alignment"] = pd.to_numeric(
            df["Alignment"],
            errors="coerce"
        )

        avg_alignment = float(df["Alignment"].mean())

        normal = float(
            self.Data_Base.Data_Base.min_normal_max_values
            .get_belt_driver_min_normal_max_values_Alignment_normal()
        )

        max_a = float(
            self.Data_Base.Data_Base.min_normal_max_values
            .get_belt_driver_min_normal_max_values_Alignment_max()
        )

        health = 100 - (
            (avg_alignment - normal) / (max_a - normal)
        ) * 100

        health = max(0, min(100, health))

        return health
    def calc_belt_Speed_Health(self):
        self.update_last_belt_data()
        df = self.filter_belt_data()
        if df.empty:
            print("No data available")
            return 0
        avg_speed = df["Speed"].mean()
        normal = self.Data_Base.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Speed_normal()
        max_s = self.Data_Base.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Speed_max()
        health = 100 - ((avg_speed - normal) / (max_s - normal)) * 100
        health = max(0, min(100, health))
        return health
    def calc_belt_Overall_Health(self):
        tension_health = self.calc_belt_Tension_Health()
        alignment_health = self.calc_belt_Alignment_Health()
        speed_health = self.calc_belt_Speed_Health()

        overall_health = (tension_health + alignment_health + speed_health ) / 3
        return overall_health
    def calc_belt_health_between_days(self):
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
    def calc_belt_Predict_Fault_Days(self, health_values):
        if len(health_values) < 2:
            return None
        # health loss per day
        daily_drop = health_values[0] - health_values[-1]
        number_of_days = len(health_values) - 1
        avg_drop_per_day = daily_drop / number_of_days
        current_health = health_values[-1]
        critical_health = 20
        if avg_drop_per_day <= 0:
            return 99
        predicted_days = (
            current_health - critical_health
        ) / avg_drop_per_day
        return round(predicted_days, 2)
    def analyse_belt_data(self):
        max_days_if_normal = self.Data_Base.Data_Base.max_days_if_normal.get_belt_driver_max_days_if_normal()
        health = self.calc_belt_Overall_Health()
        self.Data_Base.Data_Base.belt.set_Health(int(health))
        filtered_df = self.calc_belt_health_between_days()
        if filtered_df is None:
            return
        health_values = filtered_df["Belt_Health"].tolist()

        days = self.calc_belt_Predict_Fault_Days(
            health_values
        )
        status = self.set_status_based_on_health(health)
        if status == "alert" or status == "warning":
            self.Data_Base.Data_Base.belt.set_Predicted_fault(str(days))
        elif status == "normal":
            self.Data_Base.Data_Base.belt.set_Predicted_fault(str(max_days_if_normal))
