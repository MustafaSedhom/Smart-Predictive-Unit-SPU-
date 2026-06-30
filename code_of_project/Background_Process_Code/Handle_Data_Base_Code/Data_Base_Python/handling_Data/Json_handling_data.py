import json
import os
# Data class
class Handle_Json:
    # Constructor
    def __init__(self,file_path):
        self.file_path = file_path
        self.Ensure_file()
    # function to check file is exist or not
    def Ensure_file(self):
        if not os.path.exists(self.file_path):
            default_data = {}
            with open(self.file_path, "w") as file:
                json.dump(default_data, file, indent=4)
    # Function Read Json and Return it as String
    def Read_Data(self):
        try:
            with open(self.file_path, "r", encoding="utf-8-sig") as file:
                return json.load(file)

        except FileNotFoundError:
            print("❌ File not found")
            return {}

        except json.JSONDecodeError as e:
            print(f"❌ JSON format error: {e}")
            return {}

        except UnicodeDecodeError as e:
            print(f"❌ Encoding error: {e}")
            return {}
    def write_data(self, data):
        with open(self.file_path, "w", encoding="utf-8") as file:
            json.dump(data, file, indent=4, ensure_ascii=False)

