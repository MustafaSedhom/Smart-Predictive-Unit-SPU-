from .Json_handling_data import Handle_Json

class Control_Data_from_json:
    def __init__(self, json_file_path):
        self.__json_obj = Handle_Json(json_file_path)
        self.__json_data = self.__json_obj.Read_Data()
        self.json_data_access = self.__json_data

    # ======================
    # 🔹 GET METHODS
    # ======================
    def get_overall_health(self):
        return self.__json_data.get("overall_Health", 0)
    def set_overall_health(self,val):
        self.__json_data["overall_Health"] = val
        self.save_data()

    def get_active_alarms(self):
        return self.__json_data.get("Active_Alarms", 0)
    def set_active_alarms(self,val):
       self.__json_data["Active_Alarms"] = val
       self.save_data()

    def get_sensors_online(self):
        return self.__json_data.get("sensors_online", {})
    def set_sensors_online(self,val):
       self.__json_data["sensors_online"] = val
       self.save_data()
        

    def get_next_maintenance(self):
        return self.__json_data.get("Next_Maintenance", 0)
    def set_next_maintenance(self,val):
        self.__json_data["Next_Maintenance"] = val
        self.save_data()

    def get_actuators(self):
        return self.__json_data.get("Actuators", {})
    def set_actuators(self,val):
        self.__json_data["Actuators"] = val
        self.save_data()
        
    # ======================
    # 🔹 SAVE TO FILE
    # ======================

    def save_data(self):
        self.__json_obj.write_data(self.__json_data)