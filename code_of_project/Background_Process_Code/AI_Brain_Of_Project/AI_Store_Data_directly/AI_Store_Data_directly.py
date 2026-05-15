from ..AI_Store_and_Read_process_Data.AI_Store_Process_Data import (
    Store_Motor_Data, 
    Store_Pump_Data, 
    Store_Belt_Data
    )
from Background_Process_Code.Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import All_Sensor_Data_After_Receiving


def Store_Data_Directly(sensors):

    Store_Motor_Data(
        Temperature= sensors.motor.get_temperature(),
        Vibration= sensors.motor.get_vibration(),
        Current_P1= sensors.motor.get_current_phase_1(),
        Current_P2= sensors.motor.get_current_phase_2(),
        Current_P3= sensors.motor.get_current_phase_3(),
        Volt_P1= sensors.motor.get_voltage_phase_1(),
        Volt_P2= sensors.motor.get_voltage_phase_2(),
        Volt_P3= sensors.motor.get_voltage_phase_3()
    )
    Store_Belt_Data(
        Tension= sensors.belt.get_tension(),
        Alignment= sensors.belt.get_alignment(),
        Speed= sensors.belt.get_speed()
    )
    Store_Pump_Data(
        Pressure_In= sensors.pump.get_pressure_in(),
        Flow_Rate= sensors.pump.get_flow_rate(),
        Temperature= sensors.pump.get_temperature()
    )