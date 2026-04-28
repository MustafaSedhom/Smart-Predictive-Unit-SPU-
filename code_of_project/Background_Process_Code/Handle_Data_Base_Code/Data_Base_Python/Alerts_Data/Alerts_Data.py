
class AlertStruct:
    def __init__(self, id:int=0, device:str="", timestamp:str="", type:str="", message:str="", level:str="", value:float=0, unit:str="",period_name:str=""):
        self.id = id
        self.device = device
        self.timestamp = timestamp
        self.type = type
        self.message = message
        self.level = level
        self.value = value
        self.unit = unit
        self.period_name = period_name

    def to_dict(self):
        return {
            "id": self.id,
            "device": self.device,
            "timestamp": self.timestamp,
            "type": self.type,
            "message": self.message,
            "level": self.level,
            "value": self.value,
            "unit": self.unit,
            "period_name": self.period_name,
        }

class Alerts_Data:
    def __init__(self, data):
        self.__data =data
        self.Alert_struct = AlertStruct()
    # ======================
    # GET METHODS
    # ======================
    def get_list(self):
        alerts = self.__data.json_data_access.get("Alerts", {}).get("Alert_List", [])
        return [AlertStruct(**a) for a in alerts]

    # ======================
    # SET METHODS
    # ======================
    def add_alert(self, alert: AlertStruct):
        if not isinstance(alert, AlertStruct):
            return

        data = self.__data.json_data_access.setdefault("Alerts", {})
        alerts = data.setdefault("Alert_List", [])

        next_id = max([a.get("id", 0) for a in alerts], default=0) + 1
        alert.id = next_id

        alerts.append(alert.to_dict())
        self.save_data()

    def remove_alert(self, alert_id: int):
        data = self.__data.json_data_access.setdefault("Alerts", {})
        alerts = data.setdefault("Alert_List", [])

        alerts[:] = [
            a for a in alerts if a.get("id") != alert_id
        ]

        self.save_data()
    def clear_all_alerts(self):
        data = self.__data.json_data_access.setdefault("Alerts", {})
        data["Alert_List"] = []
        self.save_data()
    def get_high_alerts(self):
        return [a for a in self.get_list() if a.level == "high"]

    def get_count(self):
        return len(self.get_list())
    # ======================
    # SAVE
    # ======================
    def save_data(self):
        self.__data.save_data()