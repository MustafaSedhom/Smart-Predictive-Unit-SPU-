class Sensor_Problem_Data:
    def __init__(self, data):
        self.__data =data
    # ======================
    # GET METHODS
    # ======================
    def get_list_sensor_problem(self):
        return self.__data.get("Sensor_Problem_List", [])