from handling_Data.handling_Data import Control_Data_from_json

class Belt_Driver_Data:
    def __init__(self, file_path):
        self.__data = Control_Data_from_json(file_path)
    # ======================
    # GET METHODS
    # ======================
    def get_belt_Driver(self):
        return self.__data.json_data_access.get("Actuators", {}).get("Belt_Driver", {})
    def get_status(self):
        return self.get_belt_Driver().get("status", "unknown")
    def get_Predicted_fault(self):
        return self.get_belt_Driver().get("Predicted_fault", "unknown")
    def get_Health(self):
        return self.get_belt_Driver().get("Health", "unknown")
    def get_Sensors(self):
        return self.get_belt_Driver().get("Sensors", "unknown")
    def get_Tension(self):
        return self.get_Sensors().get("Tension", "unknown")
    def get_Alignment(self):
        return self.get_Sensors().get("Alignment", "unknown")
    def get_Speed(self):
        return self.get_Sensors().get("Speed", "unknown")
    # ======================
    # SET METHODS
    # ======================
    def set_status(self, val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["status"] = val
        self.save_data()
    def set_Predicted_fault(self,val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["Predicted_fault"] = val
        self.save_data()
    def set_Health(self,val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["Health"] = val
        self.save_data()
    def set_Sensors(self,val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["Sensors"] = val
        self.save_data()
    def set_Tension(self,val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["Sensors"]["Tension"] = val
        self.save_data()
    def set_Alignment(self,val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["Sensors"]["Alignment"] = val
        self.save_data()
    def set_Speed(self,val):
        self.__data.json_data_access["Actuators"]["Belt_Driver"]["Sensors"]["Speed"] = val
        self.save_data()
    # ======================
    # SAVE
    # ======================

    def save_data(self):
        self.__data.save_data()