class DC_Motor:
    def __init__(self, data):
        self.data = data

    def get_pressure_in(self):
        return self.data["Volt"]

    def get_flow_rate(self):
        return self.data["Current"]

    def get_temperature(self):
        return self.data["Vibration"]