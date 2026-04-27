from handling_Data.handling_Data import Control_Data_from_json

class Motor_Data:
    def __init__(self, file_path):
        self.__data = Control_Data_from_json(file_path)
    # ======================
    # GET METHODS
    # ======================
    def get_motor(self):
        return self.__data.json_data_access.get("Actuators", {}).get("Motor", {})
    def get_status(self):
        return self.get_motor().get("status", "unknown")
    def get_Predicted_fault(self):
        return self.get_motor().get("Predicted_fault", "unknown")
    def get_Health(self):
        return self.get_motor().get("Health", "unknown")
    def get_Sensors(self):
        return self.get_motor().get("Sensors", "unknown")
    def get_Temperature(self):
        return self.get_Sensors().get("Temperature", "unknown")
    def get_Vibration(self):
        return self.get_Sensors().get("Vibration", "unknown")
    def get_Current(self):
        return self.get_Sensors().get("Current", "unknown")
    def get_Current_P1(self):
        return self.get_Sensors().get("Current_p1", "unknown")
    def get_Current_P2(self):
        return self.get_Sensors().get("Current_p2", "unknown")
    def get_Current_P3(self):
        return self.get_Sensors().get("Current_p3", "unknown")
    def get_Volt_P1(self):
        return self.get_Sensors().get("volt_p1", "unknown")
    def get_Volt_P2(self):
        return self.get_Sensors().get("volt_p2", "unknown")
    def get_Volt_P3(self):
        return self.get_Sensors().get("volt_p3", "unknown")
    # ======================
    # SET METHODS
    # ======================
    def set_status(self, val):
        self.__data.json_data_access["Actuators"]["Motor"]["status"] = val
        self.save_data()
    def set_Predicted_fault(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Predicted_fault"] = val
        self.save_data()
    def set_Health(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Health"] = val
        self.save_data()
    def set_Sensors(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"] = val
        self.save_data()
    def set_Temperature(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Temperature"] = val
        self.save_data()
    def set_Vibration(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Vibration"] = val
        self.save_data()
    def set_Current(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Current"] = val
        self.save_data()
    def set_Current_P1(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Current_p1"] = val
        self.save_data()
    def set_Current_P2(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Current_p2"] = val
        self.save_data()
    def set_Current_P3(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Current_p3"] = val
        self.save_data()
    def set_Volt_P1(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["volt_p1"] = val
        self.save_data()
    def set_Volt_P2(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["volt_p2"] = val
        self.save_data()
    def set_Volt_P3(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["volt_p3"] = val
        self.save_data()
    # ======================
    # SAVE
    # ======================

    def save_data(self):
        self.__data.save_data()