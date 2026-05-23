import json

from  ..Belt_Data.Belt_Data import BeltDriver
from  ..Motor_Data.Motor_Data import Motor
from  ..Pump_Data.Pump_Data import Pump
from  ..over_all_data.over_all_data import OverAll

class All_Sensor_Data_After_Receiving:
    def __init__(self, Data_var: str):

        try:
            data = json.loads(Data_var)
        except json.JSONDecodeError:
            raise ValueError("Invalid JSON string received from UART")

        self.motor = Motor(data.get("Motor", {}))
        self.pump = Pump(data.get("Pump", {}))
        self.belt = BeltDriver(data.get("Belt_Driver", {}))
        self.overall = OverAll(data.get("Over_All", {}))