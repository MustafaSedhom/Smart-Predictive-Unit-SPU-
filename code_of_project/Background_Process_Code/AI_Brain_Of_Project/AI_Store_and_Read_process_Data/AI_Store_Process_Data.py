import pandas as pd
import os
from datetime import datetime

from ...Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    AlertStruct
)


# ---------------------------------------------------
# Store Motor Sensor Data
# ---------------------------------------------------
def Store_Motor_Data(
    file_path,
    Temperature,
    Vibration,
    Current_P_R,
    Current_P_S,
    Current_P_T,
    Volt_P_R,
    Volt_P_S,
    Volt_P_T
):

    try:

        now = datetime.now()

        data_dict = {

            "Date": now.strftime("%Y-%m-%d"),
            "Time": now.strftime("%H:%M:%S"),

            "Temperature": Temperature,
            "Vibration": Vibration,

            "Current_P_R": Current_P_R,
            "Current_P_S": Current_P_S,
            "Current_P_T": Current_P_T,

            "Volt_P_R": Volt_P_R,
            "Volt_P_S": Volt_P_S,
            "Volt_P_T": Volt_P_T
        }

        data = pd.DataFrame([data_dict])

        file_exists = os.path.isfile(file_path)

        data.to_csv(
            file_path,
            mode='a',
            header=not file_exists,
            index=False
        )

        print("Motor Data Stored Successfully")

    except Exception as e:

        print(f"Error : {e}")
# ---------------------------------------------------
# Store Pump Data
# ---------------------------------------------------
def Store_Pump_Data(
    file_path,
    Pressure_In,
    Flow_Rate,
    Temperature
):

    try:

        now = datetime.now()

        data_dict = {

            "Date": now.strftime("%Y-%m-%d"),
            "Time": now.strftime("%H:%M:%S"),

            "Pressure_In": Pressure_In,
            "Flow_Rate": Flow_Rate,
            "Temperature": Temperature
        }

        data = pd.DataFrame([data_dict])

        file_exists = os.path.isfile(file_path)

        data.to_csv(
            file_path,
            mode='a',
            header=not file_exists,
            index=False
        )

        print("Pump Data Stored Successfully")

    except Exception as e:

        print(f"Error : {e}")
# ---------------------------------------------------
# Store Belt Data
# ---------------------------------------------------
def Store_Belt_Data(
    file_path,
    Tension,
    Alignment,
    Speed
):

    try:

        now = datetime.now()

        data_dict = {

            "Date": now.strftime("%Y-%m-%d"),
            "Time": now.strftime("%H:%M:%S"),

            "Tension": Tension,
            "Alignment": Alignment,
            "Speed": Speed
        }

        data = pd.DataFrame([data_dict])

        file_exists = os.path.isfile(file_path)

        data.to_csv(
            file_path,
            mode='a',
            header=not file_exists,
            index=False
        )

        print("Belt Data Stored Successfully")

    except Exception as e:

        print(f"Error : {e}")
# ---------------------------------------------------
# Store Alarms Data
# ---------------------------------------------------
def Store_Alarms_Data(
    file_path,
    alert: AlertStruct
):

    try:
        now = datetime.now()
        data_dict = {
            "Date": now.strftime("%Y-%m-%d"),
            "Time": now.strftime("%H:%M:%S"),
            "id": alert.id,
            "device": alert.device,
            "type": alert.type,
            "message": alert.message,
            "level": alert.level,
            "value": alert.value,
            "unit": alert.unit,
        }

        data = pd.DataFrame([data_dict])

        file_exists = os.path.isfile(file_path)

        data.to_csv(
            file_path,
            mode='a',
            header=not file_exists,
            index=False
        )

        print("Alarms Data Stored Successfully")

    except Exception as e:

        print(f"Error : {e}")


