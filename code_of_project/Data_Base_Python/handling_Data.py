from Json_handling_data import Handle_Json

class Data_from_json:
    def __init__(self, json_file_path):
        self.__json_obj = Handle_Json(json_file_path)
        self.__json_data = self.__json_obj.Read_Data()
        self.Overall_Health = self.__json_data.get("overall_Health", "json error name")
        self.Active_alarms = self.__json_data.get("Active_Alarms", "json error name")
        self.Sensors_online = self.__json_data.get("sensors_online", "json error name")
        self.Next_Maintenance = self.__json_data.get("Next_Maintenance", "json error name")
        self.Actuators = self.__json_data.get("Actuators", "json error name")
        