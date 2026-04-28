
import os
from Background_Process_Code.Handle_Data_Base_Code.Data_Base_Python.Data_Base_Manger.Data_Base_Manager import DataBaseManager
from Background_Process_Code.Handle_Data_Base_Code.Data_Base_Python.Alerts_Data.Alerts_Data import AlertStruct


# base_dir = os.path.dirname(os.path.abspath(__file__))
# file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")

# DataBase = DataBaseManager(file_path)


class Access_data_Base:
    def __init__(self,file_path):
        self.Data_Base:DataBaseManager = DataBaseManager(file_path)
        
    
########################################################################