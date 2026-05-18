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
            "Time_Date_Analysis", {}
        )

    def get_motor_analysis_start_time(self):

        return self.get_time_date().get(
            "start_time_analysis",
            "unknown"
        )

    def get_motor_analysis_end_time(self):

        return self.get_time_date().get(
            "end_time_analysis",
            "unknown"
        )

    # ======================
    # SET METHODS
    # ======================

    def set_motor_analysis_start_time(self, val):

        self.__data.json_data_access[
            "Settings"
        ][
            "Time_Date_Analysis"
        ][
            "start_time_analysis"
        ] = val

        self.save_data()

    def set_motor_analysis_end_time(self, val):

        self.__data.json_data_access[
            "Settings"
        ][
            "Time_Date_Analysis"
        ][
            "end_time_analysis"
        ] = val

        self.save_data()

    # ======================
    # SAVE
    # ======================

    def save_data(self):

        self.__data.save_data()