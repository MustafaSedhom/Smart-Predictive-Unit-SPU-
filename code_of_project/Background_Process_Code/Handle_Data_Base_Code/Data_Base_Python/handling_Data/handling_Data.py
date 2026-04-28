from .Json_handling_data import Handle_Json

class Control_Data_from_json:
    def __init__(self, json_file_path):
        self.__json_obj = Handle_Json(json_file_path)
        self.__json_data = self.__json_obj.Read_Data()
        self.json_data_access = self.__json_data  
    # ======================
    # 🔹 SAVE TO FILE
    # ======================

    def save_data(self):
        self.__json_obj.write_data(self.__json_data)