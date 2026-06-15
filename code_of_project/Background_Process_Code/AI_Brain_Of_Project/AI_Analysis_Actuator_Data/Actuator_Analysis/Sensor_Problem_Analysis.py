from ..Alarm_Analysis.Send_Notification.Gmail_Massage import send_email
from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import Access_data_Base
from ....Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import All_Sensor_Data_After_Receiving


def detect_error_in_sensor_status(
        DB: Access_data_Base,
        sensor: All_Sensor_Data_After_Receiving):

    sensor_errors = sensor.sensor_problem.get_list_sensor_problem() # -> list

    if not sensor_errors:
        return

    message = (
        "Warning!\n\n"
        "A sensor connection error has been detected.\n\n"
        f"Problem Sensors: {', '.join(map(str, sensor_errors))}\n\n"
        "Please check the wiring and sensor connections."
    )

    send_email(
        database=DB,
        subject="SENSOR Connection Error",
        message=message
    )