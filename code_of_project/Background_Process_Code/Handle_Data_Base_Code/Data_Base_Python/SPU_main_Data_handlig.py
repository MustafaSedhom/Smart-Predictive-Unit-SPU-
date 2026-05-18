
import os
from .Data_Base_Manger.Data_Base_Manager import DataBaseManager
from ..Data_Base_Python.Alerts_Data.Alerts_Data import AlertStruct

class Access_data_Base:
    def __init__(self,file_path):
        self.Data_Base:DataBaseManager = DataBaseManager(file_path)
        
    
########################################################################