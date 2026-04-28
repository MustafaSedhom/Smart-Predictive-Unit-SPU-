class OverAll_Data:
    def __init__(self, data):
        self.__data =data
    # ======================
    # GET METHODS
    # ======================
    def get_over_all(self):
        return self.__data.json_data_access.get("Over_All", {})
    def get_overall_Health(self):
        return self.get_over_all().get("overall_Health", "unknown")
    def get_active_alarms(self):
        return self.get_over_all().get("Active_Alarms", "unknown")
    def get_Sensors_online(self):
        return self.get_over_all().get("sensors_online", "unknown")
    def get_Sensors_online_active(self):
        return self.get_Sensors_online().get("active", "unknown")
    def get_Sensors_online_total(self):
        return self.get_Sensors_online().get("total", "unknown")
    def get_Next_Maintenance(self):
        return self.get_over_all().get("Next_Maintenance", "unknown")
    # ======================
    # SET METHODS
    # ======================
    def set_overall_Health(self, val):
        self.__data.json_data_access["Over_All"]["overall_Health"] = val
        self.save_data()
    def set_Sensors_online_active(self,val):
        self.__data.json_data_access["Over_All"]["sensors_online"]["active"] = val
        self.save_data()
    def set_Sensors_online_total(self,val):
        self.__data.json_data_access["Over_All"]["sensors_online"]["total"] = val
        self.save_data()
    def set_active_alarms(self,val):
        self.__data.json_data_access["Over_All"]["Active_Alarms"] = val
        self.save_data()
    def set_Next_Maintenance(self,val):
        self.__data.json_data_access["Over_All"]["Next_Maintenance"] = val
        self.save_data()
    # ======================
    # SAVE
    # ======================
    def save_data(self):
        self.__data.save_data()