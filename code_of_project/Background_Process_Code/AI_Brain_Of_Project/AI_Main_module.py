#########################################################################################
# imports
import time

from ..AI_Brain_Of_Project.AI_Analysis_Actuator_Data.Analysis_Data import Analysis_Maintenance_Data

from ..Handle_Data_Base_Code.Recieve_Data_from_Slave_Board.Recieve_Data_From_Slave_Board import UARTReaderJSON

from ..Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import (
    All_Sensor_Data_After_Receiving
)

from ..Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base,
    AlertStruct
)

from .Asign_values_to_app_directly.Asign_values_to_app_directly import (
    put_sensors_value_and_send_it_to_app_directly
)

from .AI_Store_Data_directly.AI_Store_Data_directly import (Store_Data_Directly)

#########################################################################################
# variables
##### main folder
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# if you run on windows
Main_Folder_Path = "C:/Users/elmoh/OneDrive/Desktop/Ibrahim_mohamed_project"
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# if you run on linux
# Main_Folder_Path = "/home/sedhom/SPU"
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
##### main folder
API_Json_File_name = "SPU_API"
AI_Last_Data_Stored_folder_path = f"{Main_Folder_Path}/AI_Data"
motor_last_data_files_name = "Last_Motor_Data.csv"
pump_last_data_files_name = "Last_Pump_Data.csv"
belt_last_data_files_name = "Last_Belt_Data.csv"
alarms_last_data_files_name = "Last_Alarm_Data.csv"
health_last_data_files_name = "Last_Health_Data.csv"
# UART communication details
communication_port = "COM5"
communication_boudrate = 115200
#########################################################################################
APIJsonFilePath = f"{Main_Folder_Path}/{API_Json_File_name}.json"
last_data_files_paths = {
    "motor": f"{AI_Last_Data_Stored_folder_path}/{motor_last_data_files_name}",
    "pump": f"{AI_Last_Data_Stored_folder_path}/{pump_last_data_files_name}",
    "belt": f"{AI_Last_Data_Stored_folder_path}/{belt_last_data_files_name}",
    "alarms": f"{AI_Last_Data_Stored_folder_path}/{alarms_last_data_files_name}",
    "health": f"{AI_Last_Data_Stored_folder_path}/{health_last_data_files_name}"
}
#########################################################################################

if __name__ == "__main__":
    ########################################
    # # UART object
    Slave_Data = None
    # Try connect UART
    try:
        Slave_Data = UARTReaderJSON(
            port=communication_port,
            baud=communication_boudrate
        )
        print("UART Connected")
    except Exception as e:
        print("UART Disabled")
        print(e)
    # Database
    Data_Base = Access_data_Base(APIJsonFilePath)
    running = True
    while running:
        # print("AI Running")
        # READ UART DATA
        if Slave_Data:
            raw = Slave_Data.read()
        else:
            # Simulation Mode
            raw = ""  # Empty data to avoid errors
            time.sleep(1)
        # check empty
        if not raw or str(raw).strip() == "":
            time.sleep(0.1)
            continue
        # PARSE JSON
        try:
            Sensors_Data = All_Sensor_Data_After_Receiving(raw)
            analysis_data = Analysis_Maintenance_Data(Data_Base,last_data_files_paths)
        except Exception as e:
            print("Sensor parse error:", e)
            continue
        # DATABASE UPDATE
        try:
            put_sensors_value_and_send_it_to_app_directly(
                Data_Base,
                Sensors_Data
            )
        except Exception as e:
            print("Database Error:", e)
        try:
            Store_Data_Directly(
                sensors = Sensors_Data,
                data_base = Data_Base,
                health_file = last_data_files_paths['health'],
                motor_file = last_data_files_paths['motor'],
                pump_file = last_data_files_paths['pump'],
                belt_file = last_data_files_paths['belt'],
            )
        except Exception as e:
            print("Store Error:", e)
        try:
            analysis_data.analyse_all_actuators_data()
        except Exception as e:
            print("Analysis Error:", e)

        

#########################################################################################