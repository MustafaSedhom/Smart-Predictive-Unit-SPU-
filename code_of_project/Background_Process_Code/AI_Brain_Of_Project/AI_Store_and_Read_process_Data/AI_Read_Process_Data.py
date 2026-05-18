import pandas as pd

# ---------------------------------------------------
# Read All Last Pump Data
# ---------------------------------------------------
def Read_All_Last_Data_to_One_Actuator(file_path):

    try:

        data = pd.read_csv(file_path)
        return data

    except Exception as e:

        print(f"Error : {e}")

        return None
# ---------------------------------------------------
# Read Last Motor Data
# ---------------------------------------------------
def Read_Last_Motor_Data(file_path):

    try:

        data = pd.read_csv(file_path)

        # Get Last Row
        last_row = data.iloc[-1]

        # Convert To Dictionary
        motor_data = {

            "Date": last_row["Date"],
            "Time": last_row["Time"],

            "Temperature": last_row["Temperature"],
            "Vibration": last_row["Vibration"],

            "Current_P_R": last_row["Current_P_R"],
            "Current_P_S": last_row["Current_P_S"],
            "Current_P_T": last_row["Current_P_T"],

            "Volt_P_R": last_row["Volt_P_R"],
            "Volt_P_S": last_row["Volt_P_S"],
            "Volt_P_T": last_row["Volt_P_T"]
        }
        motor_data = {k: float(v) if hasattr(v, "item") else v
              for k, v in motor_data.items()}

        return motor_data

    except Exception as e:

        print(f"Error : {e}")

        return None
# ---------------------------------------------------
# Read Last Pump Data
# ---------------------------------------------------
def Read_Last_Pump_Data(file_path):

    try:

        data = pd.read_csv(file_path)

        last_row = data.iloc[-1]

        pump_data = {

            "Date": last_row["Date"],
            "Time": last_row["Time"],

            "Pressure_In": last_row["Pressure_In"],
            "Flow_Rate": last_row["Flow_Rate"],
            "Temperature": last_row["Temperature"]
        }
        pump_data = {k: float(v) if hasattr(v, "item") else v
              for k, v in pump_data.items()}
        return pump_data

    except Exception as e:

        print(f"Error : {e}")

        return None
# ---------------------------------------------------
# Read Last Belt Data
# ---------------------------------------------------
def Read_Last_Belt_Data(file_path):

    try:

        data = pd.read_csv(file_path)

        last_row = data.iloc[-1]

        belt_data = {

            "Date": last_row["Date"],
            "Time": last_row["Time"],

            "Tension": last_row["Tension"],
            "Alignment": last_row["Alignment"],
            "Speed": last_row["Speed"]
        }
        belt_data = {k: float(v) if hasattr(v, "item") else v
              for k, v in belt_data.items()}

        return belt_data

    except Exception as e:

        print(f"Error : {e}")

        return None

