

class Min_Normal_Max_Values:
    def __init__(self, data):
        self.__data = data
    # ======================
    # GET METHODS
    # ======================
    def get_min_normal_max_values(self):

        return self.__data.json_data_access.get(
            "Settings", {}
        ).get(
            "min_normal_max_values", {}
        )
    def get_motor_min_normal_max_values(self):
        return self.get_min_normal_max_values().get(
            "Motor", {}
        )
    def get_Belt_Driver_min_normal_max_values(self):
        return self.get_min_normal_max_values().get(
            "Belt_Driver", {}
        )
    def get_Pump_min_normal_max_values(self):
        return self.get_min_normal_max_values().get(
            "Pump", {}
        )
    # motor temp settings 
    def get_motor_min_normal_max_values_temperature(self):
        return self.get_motor_min_normal_max_values().get(
            "Temperature", {}
        )
    def get_motor_min_normal_max_values_Temperature_min(self):
        return self.get_motor_min_normal_max_values_temperature().get(
            "min",
            "unknown"
        )
    def get_motor_min_normal_max_values_Temperature_normal(self):
        return self.get_motor_min_normal_max_values_temperature().get(
            "normal",
            "unknown"
        )
    def get_motor_min_normal_max_values_Temperature_max(self):
        return self.get_motor_min_normal_max_values_temperature().get(
            "max",
            "unknown"
        )
    # motor vibration settings 
    def get_motor_min_normal_max_values_vibration(self):
        return self.get_motor_min_normal_max_values().get(
            "Vibration", {}
        )
    def get_motor_min_normal_max_values_Vibration_min(self):
        return self.get_motor_min_normal_max_values_vibration().get(
            "min",
            "unknown"
        )
    def get_motor_min_normal_max_values_Vibration_normal(self):
        return self.get_motor_min_normal_max_values_vibration().get(
            "normal",
            "unknown"
        )
    def get_motor_min_normal_max_values_Vibration_max(self):
        return self.get_motor_min_normal_max_values_vibration().get(
            "max",
            "unknown"
        )
    # motor voltage settings 
    def get_motor_min_normal_max_values_volt(self):
        return self.get_motor_min_normal_max_values().get(
            "Volt", {}
        )
    def get_motor_min_normal_max_values_Volt_min(self):
        return self.get_motor_min_normal_max_values_volt().get(
            "min",
            "unknown"
        )
    def get_motor_min_normal_max_values_Volt_normal(self):
        return self.get_motor_min_normal_max_values_volt().get(
            "normal",
            "unknown"
        )
    def get_motor_min_normal_max_values_Volt_max(self):
        return self.get_motor_min_normal_max_values_volt().get(
            "max",
            "unknown"
        )
    # motor current settings 
    def get_motor_min_normal_max_values_current(self):
        return self.get_motor_min_normal_max_values().get(
            "Current", {}
        )
    def get_motor_min_normal_max_values_Current_min(self):
        return self.get_motor_min_normal_max_values_current().get(
            "min",
            "unknown"
        )
    def get_motor_min_normal_max_values_Current_normal(self):
        return self.get_motor_min_normal_max_values_current().get(
            "normal",
            "unknown"
        )
    def get_motor_min_normal_max_values_Current_max(self):
        return self.get_motor_min_normal_max_values_current().get(
            "max",
            "unknown"
        )
    # pump pressure settings
    def get_pump_min_normal_max_values_pressure(self):
        return self.get_Pump_min_normal_max_values().get(
            "Pressure_In", {}
        )
    def get_pump_min_normal_max_values_Pressure_min(self):
        return self.get_pump_min_normal_max_values_pressure().get(
            "min",
            "unknown"
        )
    def get_pump_min_normal_max_values_Pressure_normal(self):
        return self.get_pump_min_normal_max_values_pressure().get(
            "normal",
            "unknown"
        )
    def get_pump_min_normal_max_values_Pressure_max(self):
        return self.get_pump_min_normal_max_values_pressure().get(
            "max",
            "unknown"
        )
    # pump flow rate settings
    def get_pump_min_normal_max_values_flow_rate(self):
        return self.get_Pump_min_normal_max_values().get(
            "Flow_Rate", {}
        )
    def get_pump_min_normal_max_values_Flow_Rate_min(self):
        return self.get_pump_min_normal_max_values_flow_rate().get(
            "min",
            "unknown"
        )
    def get_pump_min_normal_max_values_Flow_Rate_normal(self):
        return self.get_pump_min_normal_max_values_flow_rate().get(
            "normal",
            "unknown"
        )
    def get_pump_min_normal_max_values_Flow_Rate_max(self):
        return self.get_pump_min_normal_max_values_flow_rate().get(
            "max",
            "unknown"
        )
    # pump temperature settings
    def get_pump_min_normal_max_values_temperature(self):
        return self.get_Pump_min_normal_max_values().get(
            "Temperature", {}
        )
    def get_pump_min_normal_max_values_Temperature_min(self):
        return self.get_pump_min_normal_max_values_temperature().get(
            "min",
            "unknown"
        )
    def get_pump_min_normal_max_values_Temperature_normal(self):
        return self.get_pump_min_normal_max_values_temperature().get(
            "normal",
            "unknown"
        )
    def get_pump_min_normal_max_values_Temperature_max(self):
        return self.get_pump_min_normal_max_values_temperature().get(
            "max",
            "unknown"
        )
    # belt driver speed settings
    def get_belt_driver_min_normal_max_values_speed(self):
        return self.get_Belt_Driver_min_normal_max_values().get(
            "Speed", {}
        )
    def get_belt_driver_min_normal_max_values_Speed_min(self):
        return self.get_belt_driver_min_normal_max_values_speed().get(
            "min",
            "unknown"
        )
    def get_belt_driver_min_normal_max_values_Speed_normal(self):
        return self.get_belt_driver_min_normal_max_values_speed().get(
            "normal",
            "unknown"
        )
    def get_belt_driver_min_normal_max_values_Speed_max(self):

        return self.get_belt_driver_min_normal_max_values_speed().get(
            "max",
            "unknown"
        )
    # belt driver tension settings
    def get_belt_driver_min_normal_max_values_tension(self):
        return self.get_Belt_Driver_min_normal_max_values().get(
            "Tension", {}
        )
    def get_belt_driver_min_normal_max_values_Tension_min(self):
        return self.get_belt_driver_min_normal_max_values_tension().get(
            "min",
            "unknown"
        )
    def get_belt_driver_min_normal_max_values_Tension_normal(self):
        return self.get_belt_driver_min_normal_max_values_tension().get(
            "normal",
            "unknown"
        )
    def get_belt_driver_min_normal_max_values_Tension_max(self):
        return self.get_belt_driver_min_normal_max_values_tension().get(
            "max",
            "unknown"
        )
   # belt driver Alignment settings
    def get_belt_driver_min_normal_max_values_alignment(self):
        return self.get_Belt_Driver_min_normal_max_values().get(
            "Alignment", {}
        )
    def get_belt_driver_min_normal_max_values_Alignment_min(self):
        return self.get_belt_driver_min_normal_max_values_alignment().get(
            "min",
            "unknown"
        )
    def get_belt_driver_min_normal_max_values_Alignment_normal(self):
        return self.get_belt_driver_min_normal_max_values_alignment().get(
            "normal",
            "unknown"
        )
    def get_belt_driver_min_normal_max_values_Alignment_max(self):
        return self.get_belt_driver_min_normal_max_values_alignment().get(
            "max",
            "unknown"
        )





