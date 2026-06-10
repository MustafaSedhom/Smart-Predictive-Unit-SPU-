from datetime import datetime

now = datetime.now()

date = now.strftime("%Y-%m-%d")
time = now.strftime("%I:%M:%S %p")  # 12-hour format

from ....Handle_Data_Base_Code.Data_Base_Python.Alerts_Data.Alerts_Data import (
    Alerts_Data,
    AlertStruct,
) 
from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)
from ...AI_Store_and_Read_process_Data.AI_Read_Process_Data import (
    Read_All_Last_Data_to_One_Actuator,
    Read_Last_Alarms_Data
) 
from ...AI_Store_and_Read_process_Data.AI_Store_Process_Data import (
    Store_Alarms_Data
)
from .Actuators_Alarms.Motor_alarm_get import (
    motor_alarms_detect,
)
from .Actuators_Alarms.Belt_Alarm_get import (
    belt_alarm_detect,
)
from .Actuators_Alarms.Pump_alarms_get import (
    pump_alarm_detect,
)
from .Send_Notification.Gmail_Massage import (
    send_email
)
class Alarm_Analysis:

    def __init__(
        self,
        Data_Base: Access_data_Base,
        file_path_last_alarm_data: str
    ):

        self.DataBase = Data_Base
        self.file_path_alarm_last_data = file_path_last_alarm_data

        self.all_alarm_last_data = (
            Read_All_Last_Data_to_One_Actuator(
                file_path_last_alarm_data
            )
        )

    def Add_Alarm_to_file(self, alarm: AlertStruct):
        Store_Alarms_Data(
            self.file_path_alarm_last_data,
            alarm
        )

    def Add_Alarm_to_App(self, alarm: AlertStruct):
        self.DataBase.Data_Base.alert.add_alert(alarm)

    def detect_new_alarm(self):
        alarms = [
            motor_alarms_detect(self.DataBase),
            belt_alarm_detect(self.DataBase),
            pump_alarm_detect(self.DataBase),
        ]

        active_alarms = [a for a in alarms if a is not None]

        for alarm in active_alarms:
            self.Add_Alarm_to_App(alarm)
            self.Add_Alarm_to_file(alarm)
            send_email(
                database=self.DataBase,
                subject=f"SPU Alarm - {alarm.device} - {alarm.type}",
                message=f"""
                    SPU SYSTEM ALARM

                    Device      : {alarm.device}
                    Alarm Type  : {alarm.type}
                    Level       : {alarm.level}
                    Value       : {alarm.value} {alarm.unit}

                    Date        : {date}
                    Time        : {time}

                    Description :
                    {alarm.message}
                """
            )
        return active_alarms
    ###########################################################
    # master function
    def alarm_analysis(self):
        self.detect_new_alarm()
        