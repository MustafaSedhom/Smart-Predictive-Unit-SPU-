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
    def over_all_maintenance(self):
        values = []
        motor = self.Data_Base.Data_Base.motor.get_Predicted_fault()
        belt = self.Data_Base.Data_Base.belt.get_Predicted_fault()
        pump = self.Data_Base.Data_Base.pump.get_Predicted_fault()
        for v in [motor, belt, pump]:
            try:
                values.append(int(v))
            except (ValueError, TypeError):
                pass

        if values:
            next_maintenance = min(values)
        else:
            next_maintenance = 0

        self.Data_Base.Data_Base.overall.set_Next_Maintenance(
            next_maintenance
        )

        return next_maintenance
    def over_all_alarms(self):
        active_alarms = self.Data_Base.Data_Base.alert.get_alarm_count_func()
        self.Data_Base.Data_Base.overall.set_active_alarms(int(active_alarms))
    def over_all_active_sensors(self):
        pass
    def over_all_analysis(self):
        self.over_all_health()
        self.over_all_maintenance()
        self.over_all_alarms()
        self.over_all_active_sensors()