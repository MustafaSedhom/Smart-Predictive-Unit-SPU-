// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Settings/Min_Normal_Max_values_Settings/Belt_values.dart';
import 'package:spu_linux_app/DataBase/Settings/Min_Normal_Max_values_Settings/Motor_values.dart';
import 'package:spu_linux_app/DataBase/Settings/Min_Normal_Max_values_Settings/Pump_values.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';

class MinNormalMaxSetting extends StatefulWidget {
  const MinNormalMaxSetting({super.key});

  @override
  State<MinNormalMaxSetting> createState() => _MinNormalMaxSettingState();
}

class _MinNormalMaxSettingState extends State<MinNormalMaxSetting> {
  Color all_color = Colors.red;

  MotorValues? motorValue;
  PumpValues? pumpValue;
  BeltDriverValues? beltValue;

  ////////////////////////////////////////////////////////////
  /// INIT STATE

  @override
  void initState() {
    super.initState();

    load_min_max_normal_values();
  }

  ////////////////////////////////////////////////////////////
  /// LOAD

  Future<void> load_min_max_normal_values() async {
    //--------------------------------------------------------
    /// LOAD FROM JSON

    MotorValues motor_V = await loadMotorValuesFromFile();

    PumpValues pump_V = await loadPumpValuesFromFile();

    BeltDriverValues belt_V = await loadBeltDriverValuesFromFile();

    //--------------------------------------------------------
    /// SET DATA

    setState(() {
      motorValue = motor_V;
      pumpValue = pump_V;
      beltValue = belt_V;
    });

    //--------------------------------------------------------
    /// MOTOR

    if (motorValue != null) {
      //---------------- Temperature

      motor_temp_min.text = motorValue!.temp_min.toString();

      motor_temp_normal.text = motorValue!.temp_normal.toString();

      motor_temp_max.text = motorValue!.temp_max.toString();

      //---------------- Vibration

      motor_vibration_min.text = motorValue!.vibration_min.toString();

      motor_vibration_normal.text = motorValue!.vibration_normal.toString();

      motor_vibration_max.text = motorValue!.vibration_max.toString();

      //---------------- Current

      motor_current_min.text = motorValue!.current_min.toString();

      motor_current_normal.text = motorValue!.current_normal.toString();

      motor_current_max.text = motorValue!.current_max.toString();

      //---------------- Volt

      motor_volt_min.text = motorValue!.volt_min.toString();

      motor_volt_normal.text = motorValue!.volt_normal.toString();

      motor_volt_max.text = motorValue!.volt_max.toString();
    }

    //--------------------------------------------------------
    /// BELT

    if (beltValue != null) {
      //---------------- Tension

      belt_tension_min.text = beltValue!.tension_min.toString();

      belt_tension_normal.text = beltValue!.tension_normal.toString();

      belt_tension_max.text = beltValue!.tension_max.toString();

      //---------------- Alignment

      belt_alignment_min.text = beltValue!.alignment_min.toString();

      belt_alignment_normal.text = beltValue!.alignment_normal.toString();

      belt_alignment_max.text = beltValue!.alignment_max.toString();

      //---------------- Speed

      belt_speed_min.text = beltValue!.speed_min.toString();

      belt_speed_normal.text = beltValue!.speed_normal.toString();

      belt_speed_max.text = beltValue!.speed_max.toString();
    }

    //--------------------------------------------------------
    /// PUMP

    if (pumpValue != null) {
      //---------------- Pressure

      pump_pressure_min.text = pumpValue!.pressure_in_min.toString();

      pump_pressure_normal.text = pumpValue!.pressure_in_normal.toString();

      pump_pressure_max.text = pumpValue!.pressure_in_max.toString();

      //---------------- Flow Rate

      pump_flow_min.text = pumpValue!.flow_rate_min.toString();

      pump_flow_normal.text = pumpValue!.flow_rate_normal.toString();

      pump_flow_max.text = pumpValue!.flow_rate_max.toString();

      //---------------- Temperature

      pump_temp_min.text = pumpValue!.temperature_min.toString();

      pump_temp_normal.text = pumpValue!.temperature_normal.toString();

      pump_temp_max.text = pumpValue!.temperature_max.toString();
    }
  }

  ////////////////////////////////////////////////////////////
  /// SAVE

  Future<void> Save_min_max_normal_values() async {
    //--------------------------------------------------------
    /// MOTOR

    MotorValues motor_V = MotorValues(
      temp_min: double.tryParse(motor_temp_min.text) ?? 0,

      temp_normal: double.tryParse(motor_temp_normal.text) ?? 0,

      temp_max: double.tryParse(motor_temp_max.text) ?? 0,

      vibration_min: double.tryParse(motor_vibration_min.text) ?? 0,

      vibration_normal: double.tryParse(motor_vibration_normal.text) ?? 0,

      vibration_max: double.tryParse(motor_vibration_max.text) ?? 0,

      current_min: double.tryParse(motor_current_min.text) ?? 0,

      current_normal: double.tryParse(motor_current_normal.text) ?? 0,

      current_max: double.tryParse(motor_current_max.text) ?? 0,

      volt_min: double.tryParse(motor_volt_min.text) ?? 0,

      volt_normal: double.tryParse(motor_volt_normal.text) ?? 0,

      volt_max: double.tryParse(motor_volt_max.text) ?? 0,
    );

    //--------------------------------------------------------
    /// BELT

    BeltDriverValues belt_V = BeltDriverValues(
      tension_min: double.tryParse(belt_tension_min.text) ?? 0,

      tension_normal: double.tryParse(belt_tension_normal.text) ?? 0,

      tension_max: double.tryParse(belt_tension_max.text) ?? 0,

      alignment_min: double.tryParse(belt_alignment_min.text) ?? 0,

      alignment_normal: double.tryParse(belt_alignment_normal.text) ?? 0,

      alignment_max: double.tryParse(belt_alignment_max.text) ?? 0,

      speed_min: double.tryParse(belt_speed_min.text) ?? 0,

      speed_normal: double.tryParse(belt_speed_normal.text) ?? 0,

      speed_max: double.tryParse(belt_speed_max.text) ?? 0,
    );

    //--------------------------------------------------------
    /// PUMP

    PumpValues pump_V = PumpValues(
      pressure_in_min: double.tryParse(pump_pressure_min.text) ?? 0,

      pressure_in_normal: double.tryParse(pump_pressure_normal.text) ?? 0,

      pressure_in_max: double.tryParse(pump_pressure_max.text) ?? 0,

      flow_rate_min: double.tryParse(pump_flow_min.text) ?? 0,

      flow_rate_normal: double.tryParse(pump_flow_normal.text) ?? 0,

      flow_rate_max: double.tryParse(pump_flow_max.text) ?? 0,

      temperature_min: double.tryParse(pump_temp_min.text) ?? 0,

      temperature_normal: double.tryParse(pump_temp_normal.text) ?? 0,

      temperature_max: double.tryParse(pump_temp_max.text) ?? 0,
    );

    //--------------------------------------------------------
    /// SAVE TO JSON

    await saveMotorValuesToFile(motor_V);

    await savePumpValuesToFile(pump_V);

    await saveBeltDriverValuesToFile(belt_V);

    //--------------------------------------------------------

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Min Normal Max Values Saved"),
        ),
      );
    }
  }
  //////////////////////////////////////////////////////////
  /// MOTOR CONTROLLERS

  // Temperature
  final TextEditingController motor_temp_min = TextEditingController();

  final TextEditingController motor_temp_normal = TextEditingController();

  final TextEditingController motor_temp_max = TextEditingController();

  // Vibration
  final TextEditingController motor_vibration_min = TextEditingController();

  final TextEditingController motor_vibration_normal = TextEditingController();

  final TextEditingController motor_vibration_max = TextEditingController();

  // Current
  final TextEditingController motor_current_min = TextEditingController();

  final TextEditingController motor_current_normal = TextEditingController();

  final TextEditingController motor_current_max = TextEditingController();

  // Volt
  final TextEditingController motor_volt_min = TextEditingController();

  final TextEditingController motor_volt_normal = TextEditingController();

  final TextEditingController motor_volt_max = TextEditingController();

  //////////////////////////////////////////////////////////
  /// BELT CONTROLLERS

  // Tension
  final TextEditingController belt_tension_min = TextEditingController();

  final TextEditingController belt_tension_normal = TextEditingController();

  final TextEditingController belt_tension_max = TextEditingController();

  // Alignment
  final TextEditingController belt_alignment_min = TextEditingController();

  final TextEditingController belt_alignment_normal = TextEditingController();

  final TextEditingController belt_alignment_max = TextEditingController();

  // Speed
  final TextEditingController belt_speed_min = TextEditingController();

  final TextEditingController belt_speed_normal = TextEditingController();

  final TextEditingController belt_speed_max = TextEditingController();

  //////////////////////////////////////////////////////////
  /// PUMP CONTROLLERS

  // Pressure
  final TextEditingController pump_pressure_min = TextEditingController();

  final TextEditingController pump_pressure_normal = TextEditingController();

  final TextEditingController pump_pressure_max = TextEditingController();

  // Flow
  final TextEditingController pump_flow_min = TextEditingController();

  final TextEditingController pump_flow_normal = TextEditingController();

  final TextEditingController pump_flow_max = TextEditingController();

  // Temperature
  final TextEditingController pump_temp_min = TextEditingController();

  final TextEditingController pump_temp_normal = TextEditingController();

  final TextEditingController pump_temp_max = TextEditingController();

  //////////////////////////////////////////////////////////
  /// DISPOSE

  @override
  void dispose() {
    //------------------------------------------------------
    // Motor

    motor_temp_min.dispose();
    motor_temp_normal.dispose();
    motor_temp_max.dispose();

    motor_vibration_min.dispose();
    motor_vibration_normal.dispose();
    motor_vibration_max.dispose();

    motor_current_min.dispose();
    motor_current_normal.dispose();
    motor_current_max.dispose();

    motor_volt_min.dispose();
    motor_volt_normal.dispose();
    motor_volt_max.dispose();

    //------------------------------------------------------
    // Belt

    belt_tension_min.dispose();
    belt_tension_normal.dispose();
    belt_tension_max.dispose();

    belt_alignment_min.dispose();
    belt_alignment_normal.dispose();
    belt_alignment_max.dispose();

    belt_speed_min.dispose();
    belt_speed_normal.dispose();
    belt_speed_max.dispose();

    //------------------------------------------------------
    // Pump

    pump_pressure_min.dispose();
    pump_pressure_normal.dispose();
    pump_pressure_max.dispose();

    pump_flow_min.dispose();
    pump_flow_normal.dispose();
    pump_flow_max.dispose();

    pump_temp_min.dispose();
    pump_temp_normal.dispose();
    pump_temp_max.dispose();

    super.dispose();
  }

  //////////////////////////////////////////////////////////
  /// UI

  @override
  Widget build(BuildContext context) {
    return ChangesColorContainer(
      onColorChanged: (return_color) async {
        setState(() {
          all_color = return_color;
        });
      },

      shadow: AppColors.shadow_list,

      colors: AppColors.color_list,

      saveKey: "Min_Normal_Max_Setting_Color",

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            //////////////////////////////////////////////////
            /// TITLE
            Text(
              "Min Normal Max Setting",

              style: TextStyle(
                color: AppColors.Drawer_text_color,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            Gap(25),

            //////////////////////////////////////////////////
            /// MOTOR
            actuator_container(
              actuator_name: "Motor",

              actuator_icon: AppIcons.motor_Icon,

              child: Column(
                children: [
                  parameter_container(
                    title: "Temperature",

                    icon: Icons.thermostat_rounded,

                    min_controller: motor_temp_min,
                    normal_controller: motor_temp_normal,
                    max_controller: motor_temp_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Vibration",

                    icon: Icons.vibration_rounded,

                    min_controller: motor_vibration_min,
                    normal_controller: motor_vibration_normal,
                    max_controller: motor_vibration_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Current",

                    icon: Icons.bolt_rounded,

                    min_controller: motor_current_min,
                    normal_controller: motor_current_normal,
                    max_controller: motor_current_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Volt",

                    icon: Icons.electric_bolt_rounded,

                    min_controller: motor_volt_min,
                    normal_controller: motor_volt_normal,
                    max_controller: motor_volt_max,
                  ),
                ],
              ),
            ),

            Gap(25),

            //////////////////////////////////////////////////
            /// BELT DRIVER
            actuator_container(
              actuator_name: "Belt Driver",

              actuator_icon: AppIcons.motor_belt_Icon,

              child: Column(
                children: [
                  parameter_container(
                    title: "Tension",

                    icon: Icons.straighten_rounded,

                    min_controller: belt_tension_min,
                    normal_controller: belt_tension_normal,
                    max_controller: belt_tension_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Alignment",

                    icon: Icons.align_horizontal_center_rounded,

                    min_controller: belt_alignment_min,
                    normal_controller: belt_alignment_normal,
                    max_controller: belt_alignment_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Speed",

                    icon: Icons.speed_rounded,

                    min_controller: belt_speed_min,
                    normal_controller: belt_speed_normal,
                    max_controller: belt_speed_max,
                  ),
                ],
              ),
            ),

            Gap(25),

            //////////////////////////////////////////////////
            /// PUMP
            actuator_container(
              actuator_name: "Pump",

              actuator_icon: AppIcons.motor_pump_Icon,

              child: Column(
                children: [
                  parameter_container(
                    title: "Pressure In",

                    icon: Icons.compress_rounded,

                    min_controller: pump_pressure_min,
                    normal_controller: pump_pressure_normal,
                    max_controller: pump_pressure_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Flow Rate",

                    icon: Icons.water_drop_rounded,

                    min_controller: pump_flow_min,
                    normal_controller: pump_flow_normal,
                    max_controller: pump_flow_max,
                  ),

                  Gap(20),

                  parameter_container(
                    title: "Temperature",

                    icon: Icons.thermostat_rounded,

                    min_controller: pump_temp_min,
                    normal_controller: pump_temp_normal,
                    max_controller: pump_temp_max,
                  ),
                ],
              ),
            ),

            Gap(30),

            //////////////////////////////////////////////////
            /// SAVE BUTTON
            InkWell(
              onTap: () async {
                await Save_min_max_normal_values();
              },

              borderRadius: BorderRadius.circular(20),

              child: Container(
                height: 60,
                width: 220,

                decoration: BoxDecoration(
                  color: all_color,

                  borderRadius: BorderRadius.circular(20),

                  boxShadow: AppColors.shadow_list,
                ),

                child: Center(
                  child: Text(
                    "SAVE",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// ACTUATOR CONTAINER

  Widget actuator_container({
    required String actuator_name,
    required String actuator_icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: all_color,

        borderRadius: BorderRadius.circular(25),

        border: Border.all(color: AppColors.Drawer_text_color, width: 2),

        boxShadow: AppColors.shadow_list,
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Image.asset(
                actuator_icon,
                color: AppColors.Drawer_text_color,
                width: 35,
              ),

              Gap(15),

              Text(
                actuator_name,

                style: TextStyle(
                  color: AppColors.Drawer_text_color,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Gap(20),

          child,
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// PARAMETER CONTAINER

  Widget parameter_container({
    required String title,
    required IconData icon,

    required TextEditingController min_controller,

    required TextEditingController normal_controller,

    required TextEditingController max_controller,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: AppColors.shadow_list,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: AppColors.Drawer_text_color),
      ),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(icon, color: AppColors.Drawer_text_color),

              Gap(10),

              Text(
                title,

                style: TextStyle(
                  color: AppColors.Drawer_text_color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Gap(20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              children: [
                value_text_field(
                  title: "Min",

                  icon: Icons.arrow_downward_rounded,

                  controller: min_controller,
                ),

                Gap(15),

                value_text_field(
                  title: "Normal",

                  icon: Icons.check_circle_outline_rounded,

                  controller: normal_controller,
                ),

                Gap(15),

                value_text_field(
                  title: "Max",

                  icon: Icons.arrow_upward_rounded,

                  controller: max_controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////
  /// TEXT FIELD

  Widget value_text_field({
    required String title,

    required IconData icon,

    required TextEditingController controller,
  }) {
    return SizedBox(
      width: 150,

      child: TextField(
        controller: controller,

        keyboardType: const TextInputType.numberWithOptions(decimal: true),

        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        style: TextStyle(
          color: AppColors.Drawer_text_color,
          fontWeight: FontWeight.bold,
        ),

        decoration: InputDecoration(
          labelText: title,

          prefixIcon: Icon(icon, color: AppColors.Drawer_text_color),

          labelStyle: TextStyle(color: AppColors.Drawer_text_color),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),

            borderSide: BorderSide(
              color: AppColors.Drawer_text_color,
              width: 2,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),

            borderSide: BorderSide(
              color: AppColors.Drawer_text_color,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
