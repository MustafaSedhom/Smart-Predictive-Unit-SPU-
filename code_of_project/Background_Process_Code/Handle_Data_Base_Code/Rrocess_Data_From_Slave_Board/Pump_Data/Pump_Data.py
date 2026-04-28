class Pump:
    def __init__(self, data):
        self.data = data

    def get_pressure_in(self):
        return self.data["Pressure_In"]

    def get_flow_rate(self):
        return self.data["Flow_Rate"]

    def get_temperature(self):
        return self.data["Temperature"]