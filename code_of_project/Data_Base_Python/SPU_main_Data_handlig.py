
from Json_handling_data import Data
import os


base_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(base_dir, "SPU_Data_between_app_and_python_Rassbiary_pi.json")

Data_from_app = Data(file_path)

print(Data_from_app.Read_Data())
