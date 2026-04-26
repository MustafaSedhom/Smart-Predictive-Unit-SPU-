// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Motor_Card_Data.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/custom_value_sensor_card.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';
import 'package:spu_linux_app/widgets/get_state_color.dart';

class MotorDetails extends StatefulWidget {
  const MotorDetails({super.key});

  @override
  State<MotorDetails> createState() => _MotorDetailsState();
}

class _MotorDetailsState extends State<MotorDetails> {
  Motor? motor;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final globalData = await loadMotorFromFile();

    if (!mounted) return;

    setState(() {
      motor = globalData;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: GetStateColor.getColor(
            motor?.status ?? "none",
            // ignore: deprecated_member_use
          ).withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // card appbar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  // icon
                  Image.asset(AppImages.motor_Image, width: 50),
                  Spacer(),
                  // image
                  Text(
                    "Motor Details",
                    style: TextStyle(
                      color: AppColors.Drawer_text_color,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  // icon
                  Image.asset(
                    AppIcons.motor_Icon,
                    width: 50,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            CustomDivider(),
            // motor state
            Column(
              children: [
                Text(
                  "Motor State",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomValueSensorCard(
                        name: 'State',
                        value: motor?.status.toUpperCase() ?? "NONE",
                        uint: '',
                      ),
                      Gap(0.03 * screen_width),
                      CustomValueSensorCard(
                        name: 'Health',
                        value: '${motor?.Health ?? 0}',
                        uint: '%',
                      ),
                      Gap(0.03 * screen_width),
                      CustomValueSensorCard(
                        name: 'Predicted Fault',
                        value: '${motor?.Predicted_fault ?? 0}',
                        uint: 'Day',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(5),
            CustomDivider(),
            // volt sensors
            Column(
              children: [
                Text(
                  "Volt Values",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomValueSensorCard(
                        name: 'Volt P1',
                        value: '${motor?.Volt_p1 ?? 0}',
                        uint: 'V',
                      ),
                      Gap(0.05 * screen_width),
                      CustomValueSensorCard(
                        name: 'Volt P2',
                        value: '${motor?.Volt_p2 ?? 0}',
                        uint: 'V',
                      ),
                      Gap(0.05 * screen_width),
                      CustomValueSensorCard(
                        name: 'Volt P3',
                        value: '${motor?.Volt_p3 ?? 0}',
                        uint: 'V',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomDivider(),
            Gap(5),
            // Current sensor
            Column(
              children: [
                Text(
                  "Current Values",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomValueSensorCard(
                        name: "Current P1",
                        value: '${motor?.Current_p1 ?? 0}',
                        uint: 'A',
                      ),
                      Gap(0.04 * screen_width),
                      CustomValueSensorCard(
                        name: "Current P1",
                        value: '${motor?.Current_p2 ?? 0}',
                        uint: 'A',
                      ),
                      Gap(0.04 * screen_width),
                      CustomValueSensorCard(
                        name: "Current P1",
                        value: '${motor?.Current_p3 ?? 0}',
                        uint: 'A',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            CustomDivider(),
            Gap(5),
            // Current sensor
            Column(
              children: [
                Text(
                  "Other Sensors",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomValueSensorCard(
                        name: 'Temperature',
                        value: '${motor?.Temperature ?? 0}',
                        uint: '°C',
                      ),
                      Gap(0.25 * screen_width),
                      CustomValueSensorCard(
                        name: 'Vibration',
                        value: '${motor?.Vibration ?? 0}',
                        uint: 'm/s²',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
