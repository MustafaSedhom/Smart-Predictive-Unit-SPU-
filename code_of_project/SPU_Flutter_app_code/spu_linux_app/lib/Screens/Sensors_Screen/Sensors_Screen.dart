// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/widgets/App_Bar_Sensor_screen.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/widgets/set_max_days_if_normal_setting.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/widgets/set_time_analysis_widget.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarSensorScreen(),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              padding: EdgeInsets.all(10),
              children: [
                SetTimeAnalysisWidget(),
                Gap(30),
                SetMaxDaysIfNormalSetting(),
                Gap(30),
                Gap(30),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
