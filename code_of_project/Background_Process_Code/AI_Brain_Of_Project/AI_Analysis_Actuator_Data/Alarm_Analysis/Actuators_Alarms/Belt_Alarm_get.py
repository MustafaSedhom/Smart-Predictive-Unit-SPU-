
from .....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import(
    Access_data_Base
)
from .....Handle_Data_Base_Code.Data_Base_Python.Alerts_Data.Alerts_Data import (
    Alerts_Data,
    AlertStruct,
) 
def belt_alarm_detect(DB: Access_data_Base) -> AlertStruct | None:
    alarms = [
        belt_tension_alarm(DB),
        belt_speed_alarm(DB),
        belt_alignment_alarm(DB),
    ]

    for alarm in alarms:
        if alarm is not None:
            return alarm

    return None

def belt_tension_alarm(DB: Access_data_Base) -> AlertStruct | None:
    belt_tension = DB.Data_Base.belt.get_Tension()

    tension_max = DB.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Tension_max()
    tension_min = DB.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Tension_min()

    tension_level = None

    if belt_tension >= tension_max:
        tension_level = "HIGH"
    elif belt_tension <= tension_min:
        tension_level = "LOW"
    else:
        return None

    return AlertStruct(
        device="belt",
        type="tension",
        message=f"Belt Tension is {tension_level}",
        level=tension_level,
        value=float(belt_tension),
        unit="N",
    )

def belt_speed_alarm(DB: Access_data_Base) -> AlertStruct | None:
    belt_speed = DB.Data_Base.belt.get_Speed()

    speed_max = DB.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Speed_max()
    speed_min = DB.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Speed_min()

    speed_level = None

    if belt_speed >= speed_max:
        speed_level = "HIGH"
    elif belt_speed <= speed_min:
        speed_level = "LOW"
    else:
        return None

    return AlertStruct(
        device="belt",
        type="speed",
        message=f"Belt Speed is {speed_level}",
        level=speed_level,
        value=float(belt_speed),
        unit="m/s",
    )

def belt_alignment_alarm(DB: Access_data_Base) -> AlertStruct | None:
    alignment_error = DB.Data_Base.belt.get_Alignment()

    align_max = DB.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Alignment_max()
    align_min = DB.Data_Base.min_normal_max_values.get_belt_driver_min_normal_max_values_Alignment_min()

    align_level = None

    if alignment_error >= align_max:
        align_level = "HIGH"
    elif alignment_error <= align_min:
        align_level = "LOW"
    else:
        return None

    return AlertStruct(
        device="belt",
        type="alignment",
        message=f"Belt Alignment IS : {align_level}",
        level=align_level,
        value=float(alignment_error),
        unit="mm",
    )
