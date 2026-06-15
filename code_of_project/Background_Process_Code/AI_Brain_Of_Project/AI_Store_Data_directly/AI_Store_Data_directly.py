from ..AI_Store_and_Read_process_Data.AI_Store_Process_Data import (
    Store_Motor_Data, 
    Store_Pump_Data, 
    Store_Belt_Data,
    Store_Alarms_Data,
    Store_Health_Data
    )
from ...Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import All_Sensor_Data_After_Receiving
from ...Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import Access_data_Base
from ..AI_Analysis_Actuator_Data.Actuator_Analysis.Sensor_Problem_Analysis import (
    detect_error_in_sensor_status
)
def Store_Data_Directly(data_base: Access_data_Base, health_file:str, motor_file:str, pump_file:str, belt_file:str, sensors: All_Sensor_Data_After_Receiving):

    try:
        detect_error_in_sensor_status(DB=data_base,sensor=sensors)

    except Exception as e:

        print("sensor status Error:", e)

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

    try:

       Store_Health_Data(
            file_path=health_file,
            Motor_Health = data_base.Data_Base.motor.get_Health(),
            Belt_Health = data_base.Data_Base.belt.get_Health(),
            Pump_Health = data_base.Data_Base.pump.get_Health()
       )


    except Exception as e:

        print("health Store Error:", e)