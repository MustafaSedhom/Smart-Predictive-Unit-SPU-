class OverAll:
    def __init__(self, data):
        self.data = data

    def get_Count_all_Sensors(self):
        return self.data["Sensors_Count"]

    def get_Online_Sensors(self):
        return self.data["Sensors_Online"]
