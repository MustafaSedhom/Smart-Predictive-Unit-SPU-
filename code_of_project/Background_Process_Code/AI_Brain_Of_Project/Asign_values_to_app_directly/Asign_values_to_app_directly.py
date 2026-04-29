from Background_Process_Code.Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import Access_data_Base
from Background_Process_Code.Handle_Data_Base_Code.Rrocess_Data_From_Slave_Board.All_Sensor_Data_After_Processing.All_Sensor_Data_After_Processing import All_Sensor_Data_After_Receiving
# motor values
def put_motor_sensors(db, sensors):
    motor = db.motor
    m = sensors.motor

    motor.set_Temperature(m.get_temperature())
    motor.set_Vibration(m.get_vibration())
    motor.set_Current(m.get_current_phase_1())

    motor.set_Current_P1(m.get_current_phase_1())
    motor.set_Current_P2(m.get_current_phase_2())
    motor.set_Current_P3(m.get_current_phase_3())

    motor.set_Volt_P1(m.get_voltage_phase_1())
    motor.set_Volt_P2(m.get_voltage_phase_2())
    motor.set_Volt_P3(m.get_voltage_phase_3())
# belt values
def put_belt_sensor(db, sensors):
    belt = db.belt
    b = sensors.belt

    belt.set_Tension(b.get_tension())
    belt.set_Alignment(b.get_alignment())
    belt.set_Speed(b.get_speed())
# pump values
def put_pump_sensor(db, sensors):
    pump = db.pump
    p = sensors.pump
    pump.set_Pressure_In(p.get_pressure_in())
    pump.set_Flow_Rate(p.get_flow_rate())
    pump.set_Temperature(p.get_temperature())
# all values
def put_sensors_value_and_send_it_to_app_directly(Data:Access_data_Base, sensors:All_Sensor_Data_After_Receiving):
    put_motor_sensors(Data.Data_Base, sensors)
    put_belt_sensor(Data.Data_Base, sensors)
    put_pump_sensor(Data.Data_Base, sensors)