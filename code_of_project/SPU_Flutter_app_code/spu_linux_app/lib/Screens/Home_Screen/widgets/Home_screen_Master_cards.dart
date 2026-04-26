import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Belt_Driver_Card_Data.dart';
import 'package:spu_linux_app/DataBase/Motor_Card_Data.dart';
import 'package:spu_linux_app/DataBase/Pump_Card_Data.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_custom_cards.dart';
import 'package:spu_linux_app/widgets/Alarm_dialog.dart';

class HomeScreenMasterCard extends StatefulWidget {
  const HomeScreenMasterCard({super.key});

  @override
  State<HomeScreenMasterCard> createState() => _HomeScreenMasterCardState();
}

class _HomeScreenMasterCardState extends State<HomeScreenMasterCard> {
  // ignore: non_constant_identifier_names
  String? motor_status = "";

  Motor? motor;
  BeltDriver? beltDriver;
  Pump? pump;
  Timer? timer;

  // ignore: non_constant_identifier_names
  String? motor_temp_state;
  // ignore: non_constant_identifier_names
  String? belt_driver_temp_state;
  // ignore: non_constant_identifier_names
  String? pump_temp_state;

  @override
  void initState() {
    super.initState();
    // load data
    Timer.periodic(const Duration(milliseconds: 100), (_) async {
      await loadData();
      if (!mounted) return;
      // check status
      if (motor == null) return;
      // ================= MOTOR =================
      if (motor != null) {
        if (motor_temp_state == null) {
          motor_temp_state = motor!.status;
        } else if (motor!.status != motor_temp_state) {
          motor_temp_state = motor!.status;

          showAlarmDialog(
            context,
            img: AppIcons.motor_Icon,
            auto_close: true,
            close_time_seconds: 1,
            alarm_color: getColor(motor!.status),
            message:
                "motor State changed \n now status is ${motor!.status.toUpperCase()}",
          );
        }
      }

      // ================= BELT =================
      if (beltDriver != null) {
        if (belt_driver_temp_state == null) {
          belt_driver_temp_state = beltDriver!.status;
        } else if (beltDriver!.status != belt_driver_temp_state) {
          belt_driver_temp_state = beltDriver!.status;

          showAlarmDialog(
            context,
            img: AppIcons.motor_belt_Icon,
            auto_close: true,
            close_time_seconds: 1,
            alarm_color: getColor(beltDriver!.status),
            message:
                "Belt Driver State changed \n now status is ${beltDriver!.status.toUpperCase()}",
          );
        }
      }
      // ================= PUMP =================
      if (pump != null) {
        if (pump_temp_state == null) {
          pump_temp_state = pump!.status;
        } else if (pump!.status != pump_temp_state) {
          pump_temp_state = pump!.status;

          showAlarmDialog(
            context,
            img: AppIcons.motor_pump_Icon,
            auto_close: true,
            close_time_seconds: 1,
            alarm_color: getColor(pump!.status),
            message:
                "Pump State changed \n now status is ${pump!.status.toUpperCase()}",
          );
        }
      }
    });
  }

  Future<void> loadData() async {
    final motorData = await loadMotorFromFile();
    final pumpData = await loadPumpFromFile();
    final beltDriverData = await loadBeltDriverFromFile();

    if (!mounted) return;

    setState(() {
      motor = motorData;
      pump = pumpData;
      beltDriver = beltDriverData;
    });
  }

  Color getColor(String status) {
    switch (status.toUpperCase()) {
      case "NORMAL":
        return Colors.green;
      case "WARNING":
        return Colors.amber;
      case "ALERT":
      default:
        return Colors.red;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          HomeScreenMasterCustomCards(
            value: motor?.Health ?? 0,
            name: 'MOTOR',
            img: AppImages.motor_Image,
            img_icon: AppIcons.motor_Icon,
            icon: Icons.macro_off,
            status_name: motor?.status ?? "None",
            txt_1_up: 'Temperature',
            txt_1_down: '${motor?.Temperature ?? 0} \u00B0C',
            txt_2_up: 'Vibration',
            txt_2_down: '${motor?.Vibration ?? 0} m/s²',
            txt_3_up: 'Current',
            txt_3_down: '${motor?.Current ?? 0} A',
            Days: motor?.Predicted_fault ?? 0,
            view_details: () {},
            configure: () {},
          ),
          const Gap(20),
          HomeScreenMasterCustomCards(
            value: beltDriver?.Health ?? 0,
            name: 'BELT DRIVE',
            img: AppImages.motor_belt_Image,
            img_icon: AppIcons.motor_belt_Icon,
            icon: Icons.macro_off,
            status_name: beltDriver?.status ?? "None",
            txt_1_up: 'Tension',
            txt_1_down: '${beltDriver?.Tension ?? 0} N',
            txt_2_up: 'Alignment',
            txt_2_down: '${beltDriver?.Alignment ?? 0} mm',
            txt_3_up: 'Speed',
            txt_3_down: '${beltDriver?.Speed ?? 0} RPM',
            Days: beltDriver?.Predicted_fault ?? 0,
            view_details: () {},
            configure: () {},
          ),
          const Gap(20),
          HomeScreenMasterCustomCards(
            value: pump?.Health ?? 0,
            name: 'PUMP',
            img: AppImages.motor_pump_Image,
            img_icon: AppIcons.motor_pump_Icon,
            icon: Icons.macro_off,
            status_name: pump?.status ?? "None",
            txt_1_up: 'Pressure In',
            txt_1_down: '${pump?.Pressure_In ?? 0} bar',
            txt_2_up: 'Flow Rate',
            txt_2_down: '${pump?.Flow_Rate ?? 0} L/min',
            txt_3_up: 'Temperature',
            txt_3_down: '${pump?.Temperature ?? 0} \u00B0C',
            Days: pump?.Predicted_fault ?? 0,
            view_details: () {},
            configure: () {},
          ),
        ],
      ),
    );
  }
}
