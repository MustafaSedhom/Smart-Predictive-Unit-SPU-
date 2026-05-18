class Time_Date_Settings:

    def __init__(self, data):

        self.__data = data

    # ======================
    # GET METHODS
    # ======================

    def get_time_date(self):

        return self.__data.json_data_access.get(
            "Settings", {}
        ).get(
            "Time_Date", {}
        )

    def get_min_time(self):

        return self.get_time_date().get(
            "min_time",
            "unknown"
        )

    def get_max_time(self):

        return self.get_time_date().get(
            "max_time",
            "unknown"
        )

    # ======================
    # SET METHODS
    # ======================

    def set_min_time(self, val):

        self.__data.json_data_access[
            "Settings"
        ][
            "Time_Date"
        ][
            "min_time"
        ] = val

        self.save_data()

    def set_max_time(self, val):

        self.__data.json_data_access[
            "Settings"
        ][
            "Time_Date"
        ][
            "max_time"
        ] = val

        self.save_data()

    # ======================
    # SAVE
    # ======================

    def save_data(self):

        self.__data.save_data()