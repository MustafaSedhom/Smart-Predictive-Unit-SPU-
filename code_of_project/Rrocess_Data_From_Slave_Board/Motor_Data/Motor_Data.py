class Motor:
    def __init__(self, data):
        self.data = data

    # ===== Temperature =====
    def get_temperature(self):
        return self.data["temperature"]

    # ===== Vibration =====
    def get_vibration(self):
        return self.data["Vibration"]

    # ===== Voltage =====
    def get_voltage_phase_1(self):
        return self.data["Volt"]["phase_R"]

    def get_voltage_phase_2(self):
        return self.data["Volt"]["phase_S"]

    def get_voltage_phase_3(self):
        return self.data["Volt"]["phase_T"]

    # ===== Current =====
    def get_current_phase_1(self):
        return self.data["Current"]["phase_R"]

    def get_current_phase_2(self):
        return self.data["Current"]["phase_S"]

    def get_current_phase_3(self):
        return self.data["Current"]["phase_T"]