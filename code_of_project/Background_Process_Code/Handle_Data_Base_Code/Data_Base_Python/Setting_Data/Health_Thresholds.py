

class Health_Thresholds_settings:

    def __init__(self, data):
        self.__data = data
    # ======================
    # GET METHODS
    # ======================
    def get_health_thresholds(self):

        return self.__data.json_data_access.get(
            "Settings", {}
        ).get(
            "Health_Thresholds", {}
        )
    def get_motor_health_thresholds(self):

        return self.get_health_thresholds().get(
            "Motor", {}
        )
    def get_motor_health_thresholds_warning(self):

        return self.get_motor_health_thresholds().get(
            "warning",
            "unknown"
        )
    def get_motor_health_thresholds_alert(self):

        return self.get_motor_health_thresholds().get(
            "alert",
            "unknown"
        )
    def get_belt_driver_health_thresholds(self):

        return self.get_health_thresholds().get(
            "Belt_Driver", {}
        )
    def get_belt_driver_health_thresholds_warning(self):

        return self.get_belt_driver_health_thresholds().get(
            "warning",
            "unknown"
        )
    def get_belt_driver_health_thresholds_alert(self):

        return self.get_belt_driver_health_thresholds().get(
            "alert",
            "unknown"
        )
    def get_pump_health_thresholds(self):

        return self.get_health_thresholds().get(
            "Pump", {}
        )
    def get_pump_health_thresholds_warning(self):

        return self.get_pump_health_thresholds().get(
            "warning",
            "unknown"
        )
    def get_pump_health_thresholds_alert(self):

        return self.get_pump_health_thresholds().get(
            "alert",
            "unknown"
        )