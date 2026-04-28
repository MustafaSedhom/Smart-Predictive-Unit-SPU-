

import json
import json

from Belt_Data.Belt_Data import BeltDriver
from Motor_Data.Motor_Data import Motor
from Pump_Data.Pump_Data import Pump

class All_Sensor_Data_After_Receiving:
    def __init__(self, Data_var: str):
        data = json.loads(Data_var)

        self.motor = Motor(data["Motor"])
        self.pump = Pump(data["Pump"])
        self.belt = BeltDriver(data["Belt_Driver"])
