// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Belt_Driver_Card_Data.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/custom_value_sensor_card.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';
import 'package:spu_linux_app/widgets/get_state_color.dart';

class BeltDriverDetails extends StatefulWidget {
  const BeltDriverDetails({super.key});

  @override
  State<BeltDriverDetails> createState() => _BeltDriverDetailsState();
}

class _BeltDriverDetailsState extends State<BeltDriverDetails> {
  BeltDriver? belt;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final globalData = await loadBeltDriverFromFile();

    if (!mounted) return;

    setState(() {
      belt = globalData;
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
            belt?.status ?? "none",
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
                  Image.asset(AppImages.motor_belt_Image, width: 50),
                  Spacer(),
                  // image
                  Text(
                    "Belt Driver Details",
                    style: TextStyle(
                      color: AppColors.Drawer_text_color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  // icon
                  Image.asset(
                    AppIcons.motor_belt_Icon,
                    width: 50,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            CustomDivider(),
            // belt state
            Column(
              children: [
                Text(
                  "Belt Driver State",
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
                        value: belt?.status ?? "NONE",
                        uint: '',
                      ),
                      Gap(0.03 * screen_width),
                      CustomValueSensorCard(
                        name: 'Health',
                        value: '${belt?.Health ?? 0}',
                        uint: '%',
                      ),
                      Gap(0.03 * screen_width),
                      CustomValueSensorCard(
                        name: 'Predicted Fault',
                        value: '${belt?.Predicted_fault ?? 0}',
                        uint: 'Day',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(5),
            CustomDivider(),
            // sensors
            Column(
              children: [
                Text(
                  "Sensors",
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
                        name: 'Tension',
                        value: '${belt?.Tension ?? 0}',
                        uint: 'N',
                      ),
                      Gap(0.05 * screen_width),
                      CustomValueSensorCard(
                        name: 'Alignment',
                        value: '${belt?.Alignment ?? 0}',
                        uint: 'mm',
                      ),
                      Gap(0.05 * screen_width),
                      CustomValueSensorCard(
                        name: 'Speed',
                        value: '${belt?.Speed ?? 0}',
                        uint: 'RPM',
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
