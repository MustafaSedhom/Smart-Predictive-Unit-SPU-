
from ...Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (Access_data_Base)
from .Actuator_Analysis.Motor_Analysis import (Motor_Analysis)
from .Actuator_Analysis.Pump_Analysis import (Pump_Analysis)
from .Actuator_Analysis.Belt_Analysis import (Belt_Analysis)
from .Alarm_Analysis.Alarm_Analysis import(Alarm_Analysis)

class Analysis_Maintenance_Data:
    def __init__(self,DB:Access_data_Base,files_paths_Last_Data:dict):
        self.Data_Base = DB
        self.files_paths_Last_Data = files_paths_Last_Data
        self.motor_analysis = Motor_Analysis(DB,files_paths_Last_Data['motor'],files_paths_Last_Data['health'])
        self.pump_analysis = Pump_Analysis(DB,files_paths_Last_Data['pump'],files_paths_Last_Data['health'])
        self.belt_analysis = Belt_Analysis(DB,files_paths_Last_Data['belt'],files_paths_Last_Data['health'])
        self.alarm_analysis = Alarm_Analysis(DB,files_paths_Last_Data['alarms'])
    def analyse_all_actuators_data(self):
        self.motor_analysis.analyse_motor_data()
        self.pump_analysis.analyse_pump_data()
        self.belt_analysis.analyse_belt_data()
        self.alarm_analysis.alarm_analysis()
        pass