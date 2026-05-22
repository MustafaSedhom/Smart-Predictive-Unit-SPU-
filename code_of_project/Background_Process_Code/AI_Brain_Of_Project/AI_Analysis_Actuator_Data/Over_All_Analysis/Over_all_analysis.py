from ....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import Access_data_Base


class Over_All_Analysis:
    def __init__(self, DB: Access_data_Base):
        self.Data_Base = DB

    def over_all_health(self):
        # get subsystem health
        motor_health = self.Data_Base.Data_Base.motor.get_Health()
        belt_health = self.Data_Base.Data_Base.belt.get_Health()
        pump_health = self.Data_Base.Data_Base.pump.get_Health()

        # weights
        motor_weight = 0.40
        pump_weight = 0.35
        belt_weight = 0.25

        # calculate overall health
        overall_health = (
            motor_health * motor_weight +
            pump_health * pump_weight +
            belt_health * belt_weight
        )

        # store result
        self.Data_Base.Data_Base.overall.set_overall_Health(int(overall_health))

        return overall_health

    def over_all_analysis(self):
        return self.over_all_health()