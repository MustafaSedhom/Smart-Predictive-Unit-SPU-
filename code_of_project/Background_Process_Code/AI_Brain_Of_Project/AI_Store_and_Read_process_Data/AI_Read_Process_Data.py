import pandas as pd


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
            "Current": last_row["Current"],

            "Current_p1": last_row["Current_p1"],
            "Current_p2": last_row["Current_p2"],
            "Current_p3": last_row["Current_p3"],

            "volt_p1": last_row["volt_p1"],
            "volt_p2": last_row["volt_p2"],
            "volt_p3": last_row["volt_p3"]
        }

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

        return belt_data

    except Exception as e:

        print(f"Error : {e}")

        return None

