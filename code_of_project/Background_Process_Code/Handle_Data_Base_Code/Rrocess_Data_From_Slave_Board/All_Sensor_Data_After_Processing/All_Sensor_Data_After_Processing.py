import json

from  ..Belt_Data.Belt_Data import BeltDriver
from  ..Motor_Data.Motor_Data import Motor
from  ..Pump_Data.Pump_Data import DC_Motor
from  ..over_all_data.over_all_data import OverAll
from  ..Sensor_Problem.Sensor_problem_data import Sensor_Problem_Data
class All_Sensor_Data_After_Receiving:
    def __init__(self, Data_var: str):

        try:
            data = json.loads(Data_var)
        except json.JSONDecodeError:
            raise ValueError("Invalid JSON string received from UART")

        self.motor = Motor(data.get("AC_Motor", {}))
        self.dc_motor = DC_Motor(data.get("DC_Motor", {}))
        self.belt = BeltDriver(data.get("Belt_Driver", {}))
        self.overall = OverAll(data.get("Over_All", {}))
        self.sensor_problem = Sensor_Problem_Data(data.get("Sensors",{}))