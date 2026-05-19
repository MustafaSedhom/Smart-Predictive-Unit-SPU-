

class Pump_Data:
    def __init__(self, data):
        self.__data =data
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
        return self.get_Sensors().get("Pressure_In", "mudded")
    def get_Flow_Rate(self):
        return self.get_Sensors().get("Flow_Rate", "unknown")
    def get_Temperature(self):
        return self.get_Sensors().get("Temperature", "unknown")
    # ======================
    # SET METHODS
    # ======================
    def set_status(self, val):
        self.__data.json_data_access["Actuators"]["Pump"]["status"] = val
        self.save_data()
    def set_Predicted_fault(self,val):
        self.__data.json_data_access["Actuators"]["Pump"]["Predicted_fault"] = val
        self.save_data()
    def set_Health(self,val):
        self.__data.json_data_access["Actuators"]["Pump"]["Health"] = val
        self.save_data()
    def set_Sensors(self,val):
        self.__data.json_data_access["Actuators"]["Pump"]["Sensors"] = val
        self.save_data()
    def set_Pressure_In(self,val):
        self.__data.json_data_access["Actuators"]["Pump"]["Sensors"]["Pressure_In"] = val
        self.save_data()
    def set_Flow_Rate(self,val):
        self.__data.json_data_access["Actuators"]["Pump"]["Sensors"]["Flow_Rate"] = val
        self.save_data()
    def set_Temperature(self,val):
        self.__data.json_data_access["Actuators"]["Pump"]["Sensors"]["Temperature"] = val
        self.save_data()
    # ======================
    # SAVE
    # ======================

    def save_data(self):
        self.__data.save_data()