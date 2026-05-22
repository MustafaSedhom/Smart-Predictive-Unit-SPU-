from .....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import(
    Access_data_Base
)
from .....Handle_Data_Base_Code.Data_Base_Python.Alerts_Data.Alerts_Data import (
    Alerts_Data,
    AlertStruct,
)
def pump_alarm_detect(DB: Access_data_Base) -> AlertStruct | None:
    alarms = [
        pump_temp_alarm(DB),
        pump_flow_alarm(DB),
        pump_pressure_alarm(DB),
    ]

    for alarm in alarms:
        if alarm is not None:
            return alarm

    return None

def pump_temp_alarm(DB: Access_data_Base) -> AlertStruct | None:
    pump_temp = DB.Data_Base.pump.get_Temperature()

    temp_max = DB.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Temperature_max()
    temp_min = DB.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Temperature_min()

    temp_level = None

    if pump_temp >= temp_max:
        temp_level = "HIGH"
    elif pump_temp <= temp_min:
        temp_level = "LOW"
    else:
        return None

    return AlertStruct(
        device="pump",
        type="temp",
        message=f"Pump Temperature is {temp_level}",
        level=temp_level,
        value=float(pump_temp),
        unit="°C",
    )

def pump_flow_alarm(DB: Access_data_Base) -> AlertStruct | None:
    flow_rate = DB.Data_Base.pump.get_Flow_Rate()

    flow_max = DB.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Flow_Rate_max()
    flow_min = DB.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Flow_Rate_min()

    flow_level = None

    if flow_rate >= flow_max:
        flow_level = "HIGH"
    elif flow_rate <= flow_min:
        flow_level = "LOW"
    else:
        return None

    return AlertStruct(
        device="pump",
        type="FLOW_RATE",
        message=f"Pump Flow Rate is {flow_level}",
        level=flow_level,
        value=float(flow_rate),
        unit="L/min",
    )

def pump_pressure_alarm(DB: Access_data_Base) -> AlertStruct | None:
    pressure = DB.Data_Base.pump.get_Pressure_In()

    pressure_max = DB.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Pressure_max()
    pressure_min = DB.Data_Base.min_normal_max_values.get_pump_min_normal_max_values_Pressure_min()

    pressure_level = None

    if pressure >= pressure_max:
        pressure_level = "HIGH"
    elif pressure <= pressure_min:
        pressure_level = "LOW"
    else:
        return None

    return AlertStruct(
        device="pump",
        type="pressure",
        message=f"Pump Pressure is {pressure_level}",
        level=pressure_level,
        value=float(pressure),
        unit="bar",
    )




