// ignore_for_file: non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Settings/Health_threshold_setting/Belt_Health_threashold.dart';
import 'package:spu_linux_app/DataBase/Settings/Health_threshold_setting/Motor_Health_threashold.dart';
import 'package:spu_linux_app/DataBase/Settings/Health_threshold_setting/Pump_Health_threashold.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/changes_color_container.dart';

class HealthThreshold extends StatefulWidget {
  const HealthThreshold({super.key});

  @override
  State<HealthThreshold> createState() => _HealthThresholdState();
}

class _HealthThresholdState extends State<HealthThreshold> {
  Color all_color = Colors.red;

  // =========================
  // Controllers
  // =========================

  final TextEditingController motor_warning_controller =
      TextEditingController();

  final TextEditingController motor_alert_controller = TextEditingController();

  final TextEditingController pump_warning_controller = TextEditingController();

  final TextEditingController pump_alert_controller = TextEditingController();

  final TextEditingController belt_warning_controller = TextEditingController();

  final TextEditingController belt_alert_controller = TextEditingController();

  ////////////////////////////////////////////////////////////
  /// INIT
  ////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();

    load_data();
  }

  ////////////////////////////////////////////////////////////
  /// LOAD DATA
  ////////////////////////////////////////////////////////////

  Future<void> load_data() async {
    //------------------------------------------------------
    // Motor

    MotorHealthThreshold motorData = await loadMotorHealthThresholdFromFile();

    motor_warning_controller.text = motorData.warning_threshold.toString();

    motor_alert_controller.text = motorData.alert_threshold.toString();

    //------------------------------------------------------
    // Belt

    BeltHealthThreshold beltData = await loadBeltHealthThresholdFromFile();

    belt_warning_controller.text = beltData.warning_threshold.toString();

    belt_alert_controller.text = beltData.alert_threshold.toString();

    //------------------------------------------------------
    // Pump

    PumpHealthThreshold pumpData = await loadPumpHealthThresholdFromFile();

    pump_warning_controller.text = pumpData.warning_threshold.toString();

    pump_alert_controller.text = pumpData.alert_threshold.toString();

    //------------------------------------------------------

    setState(() {});
  }

  ////////////////////////////////////////////////////////////
  /// SAVE DATA
  ////////////////////////////////////////////////////////////

  Future<void> save_data() async {
    //------------------------------------------------------
    // Motor

    await saveMotorHealthThresholdToFile(
      MotorHealthThreshold(
        warning_threshold: int.tryParse(motor_warning_controller.text) ?? 0,

        alert_threshold: int.tryParse(motor_alert_controller.text) ?? 0,
      ),
    );

    //------------------------------------------------------
    // Belt

    await saveBeltHealthThresholdToFile(
      BeltHealthThreshold(
        warning_threshold: int.tryParse(belt_warning_controller.text) ?? 0,

        alert_threshold: int.tryParse(belt_alert_controller.text) ?? 0,
      ),
    );

    //------------------------------------------------------
    // Pump

    await savePumpHealthThresholdToFile(
      PumpHealthThreshold(
        warning_threshold: int.tryParse(pump_warning_controller.text) ?? 0,

        alert_threshold: int.tryParse(pump_alert_controller.text) ?? 0,
      ),
    );

    //------------------------------------------------------
    // SnackBar

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Threshold Saved Successfully",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // =========================
  // Dispose
  // =========================

  @override
  void dispose() {
    motor_warning_controller.dispose();
    motor_alert_controller.dispose();

    pump_warning_controller.dispose();
    pump_alert_controller.dispose();

    belt_warning_controller.dispose();
    belt_alert_controller.dispose();

    super.dispose();
  }

  // =========================
  // UI
  // =========================

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
      saveKey: "Health_threshold_setting_color",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // =========================
              // Title
              // =========================
              Text(
                "Actuators Health Threshold",
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.Drawer_text_color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(20),
              // =========================
              // Motor
              // =========================
              actuator_box(
                title: "Motor",
                icon: AppIcons.motor_Icon,
                warning_controller: motor_warning_controller,
                alert_controller: motor_alert_controller,
              ),
              Gap(20),
              // =========================
              // Pump
              // =========================
              actuator_box(
                title: "Belt",
                icon: AppIcons.motor_belt_Icon,
                warning_controller: belt_warning_controller,
                alert_controller: belt_alert_controller,
              ),
              Gap(20),
              actuator_box(
                title: "Pump",
                icon: AppIcons.motor_pump_Icon,
                warning_controller: pump_warning_controller,
                alert_controller: pump_alert_controller,
              ),
              // =========================
              // Belt
              // =========================
              Gap(20),
              // =========================
              // Save Button
              // =========================
              InkWell(
                onTap: () async {
                  await save_data();
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // Custom Actuator Box
  // =========================

  Widget actuator_box({
    required String title,
    required String icon,
    required TextEditingController warning_controller,
    required TextEditingController alert_controller,
  }) {
    return Container(
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
              Image.asset(icon, color: AppColors.Drawer_text_color, width: 35),
              Gap(20),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.Drawer_text_color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gap(10),
          // Warning
          TextField(
            controller: warning_controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            style: TextStyle(
              color: AppColors.Drawer_text_color,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              labelText: "Warning",
              labelStyle: TextStyle(color: AppColors.Drawer_text_color),
              prefixIcon: Icon(
                Icons.warning_amber_rounded,
                color: Colors.deepOrange.shade900,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.Drawer_text_color,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.Drawer_text_color,
                  width: 3,
                ),
              ),
            ),
          ),
          Gap(15),
          // Alert
          TextField(
            controller: alert_controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            style: TextStyle(
              color: AppColors.Drawer_text_color,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              labelText: "Alert",
              labelStyle: TextStyle(color: AppColors.Drawer_text_color),
              prefixIcon: Icon(
                Icons.notification_important,
                color: Colors.redAccent.shade700,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.Drawer_text_color,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: AppColors.Drawer_text_color,
                  width: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
