
from .....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import(
    Access_data_Base
)
from .....Handle_Data_Base_Code.Data_Base_Python.Alerts_Data.Alerts_Data import (
    Alerts_Data,
    AlertStruct,
) 
def motor_alarms_detect(DB: Access_data_Base) -> AlertStruct | None:
    alarms = [
        motor_current_alarm(DB),
        motor_volt_alarm(DB),
        motor_temp_alarm(DB),
        motor_vibration_alarm(DB),
    ]

    for alarm in alarms:
        if alarm is not None:
            return alarm

    return None

def motor_current_alarm(DB: Access_data_Base) -> AlertStruct | None:
    motor_current_p1 = DB.Data_Base.motor.get_Current_P1()
    motor_current_p2 = DB.Data_Base.motor.get_Current_P2()
    motor_current_p3 = DB.Data_Base.motor.get_Current_P3()

    motor_max_current = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Current_max()
    motor_min_current = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Current_min()

    # Use worst case (safest for motors)
    motor_now_current = max(motor_current_p1, motor_current_p2, motor_current_p3)

    current_level = None

    if motor_now_current >= motor_max_current:
        current_level = "HIGH"
    elif motor_now_current <= motor_min_current:
        current_level = "LOW"
    else:
        return None  # normal state

    return AlertStruct(
        device="AC motor",
        type="current",
        message=f"AC Motor Current is {current_level}",
        level=current_level,
        value=float(motor_now_current),
        unit="A",
    )
def motor_volt_alarm(DB: Access_data_Base) -> AlertStruct | None:
    motor_volt_p1 = DB.Data_Base.motor.get_Volt_P1()
    motor_volt_p2 = DB.Data_Base.motor.get_Volt_P2()
    motor_volt_p3 = DB.Data_Base.motor.get_Volt_P3()

    motor_max_volt = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Volt_max()
    motor_min_volt = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Volt_min()

    # Use worst case (safest for motors)
    motor_now_volt = max(motor_volt_p1, motor_volt_p2, motor_volt_p3)

    volt_level = None

    if motor_now_volt >= motor_max_volt:
        volt_level = "HIGH"
    elif motor_now_volt <= motor_min_volt:
        volt_level = "LOW"
    else:
        return None  # normal state

    return AlertStruct(
        device="AC motor",
        type="volt",
        message=f"AC Motor Volt is {volt_level}",
        level=volt_level,
        value=float(motor_now_volt),
        unit="V",
    )
def motor_temp_alarm(DB: Access_data_Base) -> AlertStruct | None:
    motor_temp = DB.Data_Base.motor.get_Temperature()

    temp_max = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Temperature_max()
    temp_min = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Temperature_min()

    temp_level = None

    if motor_temp >= temp_max:
        temp_level = "HIGH"
    elif motor_temp <= temp_min:
        temp_level = "LOW"
    else:
        return None  # normal state

    return AlertStruct(
        device="AC motor",
        type="temp",
        message=f"AC Motor Temperature is {temp_level}",
        level=temp_level,
        value=float(motor_temp),
        unit="°C",
    )
def motor_vibration_alarm(DB: Access_data_Base) -> AlertStruct | None:
    motor_vibration = DB.Data_Base.motor.get_Vibration()

    vib_max = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Vibration_max()
    vib_min = DB.Data_Base.min_normal_max_values.get_motor_min_normal_max_values_Vibration_min()

    vib_level = None

    if motor_vibration >= vib_max:
        vib_level = "HIGH"
    elif motor_vibration <= vib_min:
        vib_level = "LOW"
    else:
        return None  # normal state

    return AlertStruct(
        device="AC motor",
        type="noise",
        message=f"AC Motor Vibration is {vib_level}",
        level=vib_level,
        value=float(motor_vibration),
        unit="m/s²",
    )







