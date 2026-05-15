from ..AI_Store_and_Read_process_Data.AI_Store_Process_Data import (
    Store_Motor_Data, 
    Store_Pump_Data, 
    Store_Belt_Data
    )
from Background_Process_Code.Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import All_Sensor_Data_After_Receiving


def Store_Data_Directly(motor_file:str, pump_file:str, belt_file:str, sensors: All_Sensor_Data_After_Receiving):

    try:

        Store_Motor_Data(
            file_path=motor_file,
            Temperature=sensors.motor.get_temperature(),
            Vibration=sensors.motor.get_vibration(),
            Current_P_R=sensors.motor.get_current_phase_1(),
            Current_P_S=sensors.motor.get_current_phase_2(),
            Current_P_T=sensors.motor.get_current_phase_3(),
            Volt_P_R=sensors.motor.get_voltage_phase_1(),
            Volt_P_S=sensors.motor.get_voltage_phase_2(),
            Volt_P_T=sensors.motor.get_voltage_phase_3()
        )

    except Exception as e:

        print("Motor Store Error:", e)

    try:

        Store_Belt_Data(
            file_path=belt_file,
            Tension=sensors.belt.get_tension(),
            Alignment=sensors.belt.get_alignment(),
            Speed=sensors.belt.get_speed()
        )

    except Exception as e:

        print("Belt Store Error:", e)

    try:

        Store_Pump_Data(
            file_path=pump_file,
            Pressure_In=sensors.pump.get_pressure_in(),
            Flow_Rate=sensors.pump.get_flow_rate(),
            Temperature=sensors.pump.get_temperature()
        )

    except Exception as e:

        print("Pump Store Error:", e)