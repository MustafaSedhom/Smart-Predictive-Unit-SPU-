import pandas as pd
import os
from datetime import datetime


# ---------------------------------------------------
# Store Motor Sensor Data
# ---------------------------------------------------
def Store_Motor_Data(
    file_path,
    Temperature,
    Vibration,
    Current_p1,
    Current_p2,
    Current_p3,
    volt_p1,
    volt_p2,
    volt_p3
):

    try:

        now = datetime.now()

        data_dict = {

            "Date": now.strftime("%Y-%m-%d"),
            "Time": now.strftime("%H:%M:%S"),

            "Temperature": Temperature,
            "Vibration": Vibration,

            "Current_P_R": Current_p1,
            "Current_P_S": Current_p2,
            "Current_P_T": Current_p3,

            "volt_P_R": volt_p1,
            "volt_P_S": volt_p2,
            "volt_P_T": volt_p3
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