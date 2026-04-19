from handling_Data.handling_Data import Control_Data_from_json

class Pump_Data:
    def __init__(self, file_path):
        self.__data = Control_Data_from_json(file_path)
    # ======================
    # GET METHODS
    # ======================
    def get_pump(self):
        return self.__data.json_data_access.get("Actuators", {}).get("Pump", {})
    def get_status(self):
        return self.get_pump().get("status", "unknown")
    def get_Predicted_fault(self):
        return self.get_pump().get("Predicted_fault", "unknown")
    def get_Health(self):
        return self.get_pump().get("Health", "unknown")
    def get_Sensors(self):
        return self.get_pump().get("Sensors", "unknown")
    def get_Pressure_In(self):
        return self.get_Sensors().get("Pressure_In", "unknown")
    def get_Flow_Rate(self):
        return self.get_Sensors().get("Flow_Rate", "unknown")
    def get_Temperature(self):
        return self.get_Sensors().get("Temperature", "unknown")
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
    def set_Pressure_In(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Pressure_In"] = val
        self.save_data()
    def set_Flow_Rate(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Flow_Rate"] = val
        self.save_data()
    def set_Temperature(self,val):
        self.__data.json_data_access["Actuators"]["Motor"]["Sensors"]["Temperature"] = val
        self.save_data()
    # ======================
    # SAVE
    # ======================

    def save_data(self):
        self.__data.save_data()