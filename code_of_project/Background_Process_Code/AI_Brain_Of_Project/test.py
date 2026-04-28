#########################################################################################
############## imports ##########
# import receive Data
from ..Handle_Data_Base_Code.Recieve_Data_from_Slave_Board.Recieve_Data_From_Slave_Board import UARTReaderJSON 
# import Process Data
from ..Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import All_Sensor_Data_After_Receiving
# import Data Base 
from ..Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import Access_data_Base,AlertStruct
#########################################################################################
############## variables ##########
###################
# API.json path
APIJsonFilePath = "C:/Users/elmoh/OneDrive/Desktop/API.json"
###################
###################
# communication setting
communication_port = "COM3"
# communication_port = '/dev/serial0'
communication_boudrate = 9600
###################
receive_Data_from_Slave_Board = """
{
    "Motor":{
        "temperature":99,
        "Vibration":33.1,
        "Volt":{
            "phase_1":220.0,
            "phase_2":220.0,
            "phase_3":220.0
        },
        "Current":{
            "phase_1":2.1,
            "phase_2":2.3,
            "phase_3":2.1
        }
    },
    "Belt_Driver":{
        "Tension":3333,
        "Alignment":33.1,
        "Speed":33.1
    },
    "Pump":{
        "Pressure_In":77.2,
        "Flow_Rate":33.1,
        "Temperature":33.1
    }
}
"""
#########################################################################################
############## objects ##########
# Slave_Data = UARTReaderJSON(port=communication_port,baud=communication_boudrate)
# Sensors_Data = All_Sensor_Data_After_Receiving(Slave_Data.read())
Data_Base = Access_data_Base(APIJsonFilePath)
Sensors_Data = All_Sensor_Data_After_Receiving(receive_Data_from_Slave_Board)
#########################################################################################
############## main code ##########
if __name__ == "__main__":
    Data_Base.Data_Base.overall.set_Next_Maintenance(2)
    Data_Base.Data_Base.gear.set_unit("mm")
    Data_Base.Data_Base.analysis.add_point(20,20)
    Data_Base.Data_Base.analysis.add_label("50","50")
    Data_Base.Data_Base.motor.set_Temperature(Sensors_Data.motor.get_temperature())
    Data_Base.Data_Base.belt.set_Tension(Sensors_Data.belt.get_tension())
    Data_Base.Data_Base.pump.set_Flow_Rate(Sensors_Data.pump.get_flow_rate())
    pass