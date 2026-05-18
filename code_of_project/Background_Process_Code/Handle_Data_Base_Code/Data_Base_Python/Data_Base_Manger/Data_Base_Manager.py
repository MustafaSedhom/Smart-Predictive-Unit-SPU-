from datetime import datetime
from  ...Data_Base_Python.Actuators_Data.Motor_Data import Motor_Data
from  ...Data_Base_Python.Actuators_Data.Belt_Driver_Data import Belt_Driver_Data
from  ...Data_Base_Python.Actuators_Data.Pump_Data import Pump_Data
from  ...Data_Base_Python.OverAll_Data.OverAll_Data import OverAll_Data
from  ...Data_Base_Python.Alerts_Data.Alerts_Data import Alerts_Data,AlertStruct
from  ...Data_Base_Python.Analysis_Data.Analysis_Data import AnalysisData
from  ...Data_Base_Python.Gear_Setting_Data.Gear_Setting_Data import GearSettingData
from  ...Data_Base_Python.handling_Data.handling_Data import Control_Data_from_json
from  ...Data_Base_Python.Setting_Data.Limit_Time_Date_Data import Time_Date_Settings
from  ...Data_Base_Python.Setting_Data.Health_Thresholds import Health_Thresholds_settings
from  ...Data_Base_Python.Setting_Data.Min_Normal_Max_Values import Min_Normal_Max_Values
class Time_Date_conversion:
    def __init__(self):
        pass
    def datetime_to_iso(self, year=0, month=0, day=0, hour=0, minute=0, second=0):
        dt = datetime(year, month, day, hour, minute, second)
        return dt.strftime("%Y-%m-%dT%H:%M:%S")
    def iso_to_datetime(self, iso_str):
        return datetime.strptime(iso_str, "%Y-%m-%dT%H:%M:%S")
    def to_iso(self, dt: datetime):
        return dt.strftime("%Y-%m-%dT%H:%M:%S")
class DataBaseManager:
    def __init__(self, file_path):
        self.data = Control_Data_from_json(file_path)
        self.motor = Motor_Data(self.data)
        self.pump = Pump_Data(self.data)
        self.belt = Belt_Driver_Data(self.data)
        self.overall = OverAll_Data(self.data)
        self.alert = Alerts_Data(self.data)
        self.analysis = AnalysisData(self.data)
        self.gear = GearSettingData(self.data)
        self.time_date_handling = Time_Date_conversion()
        self.time_date_settings = Time_Date_Settings(self.data)
        self.health_thresholds = Health_Thresholds_settings(self.data)
        self.min_normal_max_values = Min_Normal_Max_Values(self.data)