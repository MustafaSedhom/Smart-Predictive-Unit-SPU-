class Max_Days_if_normal_Settings:

    def __init__(self, data):

        self.__data = data

    # ======================
    # GET METHODS
    # ======================

    def get_max_days_if_normal(self):

        return self.__data.json_data_access.get(
            "Settings", {}
        ).get(
            "max_Days_if_normal", {}
        )

    def get_motor_max_days_if_normal(self):

        return self.get_max_days_if_normal().get(
            "Motor",
            "unknown"
        )

    def get_belt_driver_max_days_if_normal(self):

        return self.get_max_days_if_normal().get(
            "Belt_Driver",
            "unknown"
        )
    def get_pump_max_days_if_normal(self):

        return self.get_max_days_if_normal().get(
            "Pump",
            "unknown"
        )
