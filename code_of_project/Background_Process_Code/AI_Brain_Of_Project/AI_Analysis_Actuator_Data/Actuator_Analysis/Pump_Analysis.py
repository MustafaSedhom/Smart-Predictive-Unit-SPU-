
from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)
from ...AI_Store_and_Read_process_Data.AI_Read_Process_Data import (
    Read_All_Last_Data_to_One_Actuator,
    Read_Last_Pump_Data,
    Read_All_Last_Health_Data
)  
import pandas as pd
class Pump_Analysis:
    def __init__(self,DB:Access_data_Base,file_path_last_pump_data:str,file_path_last_health_data:str):
        self.Data_Base = DB
        self.file_path_last_pump_data = file_path_last_pump_data
        self.file_path_last_health_data = file_path_last_health_data
        self.last_pump_data = Read_Last_Pump_Data(file_path_last_pump_data)
        self.all_pump_last_data = Read_All_Last_Data_to_One_Actuator(file_path_last_pump_data)
    def update_last_pump_data(self):
        self.last_pump_data = Read_Last_Pump_Data(self.file_path_last_pump_data)
        self.all_pump_last_data = Read_All_Last_Data_to_One_Actuator(self.file_path_last_pump_data)
    def filter_pump_data(self):

        df = Read_All_Last_Data_to_One_Actuator(
            self.file_path_last_pump_data
        )

        # Convert Date + Time to DateTime
        df["DateTime"] = pd.to_datetime(
            df["Date"].astype(str) + " " + df["Time"].astype(str),
            errors="coerce"
        )

        # Convert numeric columns
        numeric_cols = [
            "Temperature",
            "Pressure_In",
            "Flow_Rate",
            "Pump_Health"
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
        if health < self.Data_Base.Data_Base.health_thresholds.get_pump_health_thresholds_alert():
            self.Data_Base.Data_Base.pump.set_status("alert")
        elif health < self.Data_Base.Data_Base.health_thresholds.get_pump_health_thresholds_warning():
            self.Data_Base.Data_Base.pump.set_status("warning")
        else:
            self.Data_Base.Data_Base.pump.set_status("normal") 
    def calc_pump_temperature_Health(self):

        self.update_last_pump_data()

        df = self.filter_pump_data()

        if df.empty:
            print("No data available")
            return 0

        avg_temp = df["Temperature"].mean()

        normal = self.Data_Base.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Temperature_normal()
        max_t = self.Data_Base.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Temperature_max()

        health = 100 - ((avg_temp - normal) / (max_t - normal)) * 100

        health = max(0, min(100, health))
        return health
    def calc_pump_pressure_Health(self):

        self.update_last_pump_data()

        df = self.filter_pump_data()

        if df.empty:
            print("No data available")
            return 0

        # convert column to numeric
        df["Pressure_In"] = pd.to_numeric(
            df["Pressure_In"],
            errors="coerce"
        )

        avg_pressure = float(df["Pressure_In"].mean())

        normal = float(
            self.Data_Base.Data_Base.min_normal_max_values
            .get_pump_min_normal_max_values_Pressure_normal()
        )

        max_p = float(
            self.Data_Base.Data_Base.min_normal_max_values
            .get_pump_min_normal_max_values_Pressure_max()
        )

        health = 100 - (
            (avg_pressure - normal) / (max_p - normal)
        ) * 100

        health = max(0, min(100, health))

        return health
    def calc_pump_Flow_Rate_Health(self):
        self.update_last_pump_data()
        df = self.filter_pump_data()
        if df.empty:
            print("No data available")
            return 0
        avg_flow_rate = df["Flow_Rate"].mean()
        normal = self.Data_Base.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Flow_Rate_normal()
        max_f = self.Data_Base.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Flow_Rate_max()
        health = 100 - ((avg_flow_rate - normal) / (max_f - normal)) * 100
        health = max(0, min(100, health))
        return health
    def calc_pump_overall_Health(self):
        temp_health = self.calc_pump_temperature_Health()
        pressure_health = self.calc_pump_pressure_Health()
        flow_rate_health = self.calc_pump_Flow_Rate_Health()

        overall_health = (temp_health + pressure_health + flow_rate_health ) / 3
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
    def calc_pump_predict_fault_days(self, health_values):
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
    def analyse_pump_data(self): 
        health = self.calc_pump_overall_Health()
        self.Data_Base.Data_Base.pump.set_Health(int(health))
        filtered_df = self.calc_health_between_days()
        if filtered_df is None:
            return
        health_values = filtered_df["Pump_Health"].tolist()

        days = self.calc_pump_predict_fault_days(
            health_values
        )
        self.set_status_based_on_health(health)
        self.Data_Base.Data_Base.pump.set_Predicted_fault(days)
