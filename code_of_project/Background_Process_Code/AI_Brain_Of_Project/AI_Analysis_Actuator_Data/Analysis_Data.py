
from ...Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (Access_data_Base)
from .Actuator_Analysis.Motor_Analysis import (Motor_Analysis)

class Analysis_Maintenance_Data:
    def __init__(self,DB:Access_data_Base,files_paths_Last_Data:dict):
        self.Data_Base = DB
        self.files_paths_Last_Data = files_paths_Last_Data
        self.motor_analysis = Motor_Analysis(DB,files_paths_Last_Data['motor'])
        self.motor_analysis.analyse_motor_data()