#########################################################################################
# imports
import time

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

#########################################################################################

# variables
APIJsonFilePath = "C:/Users/elmoh/OneDrive/Desktop/Ibrahim_mohamed_project/API.json"

communication_port = "COM5"
communication_boudrate = 115200

#########################################################################################

if __name__ == "__main__":

    # UART object
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

        print("AI Running")

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

            print("DB update error:", e)

#########################################################################################