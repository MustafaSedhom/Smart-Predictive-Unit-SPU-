
from ...Handle_Data_Base_Code.Data_Base_Python.Setting_Data.Limit_Time_Date_Data import Time_Date_Settings
from ...Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (Access_data_Base)

class Analysis_Data:
    def __init__(self,APIJsonFilePath,min_time, max_time):
        self.min_time = min_time
        self.max_time = max_time
        self.APIJsonFilePath = APIJsonFilePath