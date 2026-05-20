import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class AppBarSensorScreen extends StatelessWidget {
  const AppBarSensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),

        Text(
          "Sensor Analysis Settings",
          style: TextStyle(
            color: AppColors.home_screen_title_alarm_color,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Gap(10),
        const CustomDivider(),
      ],
    );
  }
}
