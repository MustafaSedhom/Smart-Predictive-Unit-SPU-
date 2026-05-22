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
###################

#   IconData alert_problem_icon(String problem) {
#     String my_problem = problem.toUpperCase();
#     if (my_problem == "TEMP" || my_problem == "TEMPERATURE") {
#       return Icons.thermostat_rounded;
#     } else if (my_problem == "CURRENT") {
#       return Icons.bolt;
#     } else if (my_problem == "NOISE") {
#       return Icons.graphic_eq;
#     } else if (my_problem == "SPEED") {
#       return Icons.speed;
#     } else if (my_problem == "TENSION") {
#       return Icons.compress;
#     } else if (my_problem == "ALIGN" || my_problem == "ALIGNMENT") {
#       return Icons.straighten;
#     } else if (my_problem == "FLOW RATE" || my_problem == "FLOW_RATE") {
#       return Icons.waves_rounded;
#     } else if (my_problem == "PRESSURE") {
#       return Icons.compress;
#     }
#     return Icons.circle;
#   }

###################
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
        pass

    def alarm_analysis(self):

        print(self.all_alarm_last_data)

        self.Add_Alarm_to_App(
            AlertStruct(
                id=0,
                device="motor",
                type="temp",
                message="mustafa",
                level="low",
                value=45,
                unit="C",
            )
        )