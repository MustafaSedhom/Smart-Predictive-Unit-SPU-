// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/Motor_details.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/belt_Driver_details.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/pump_details.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10),
        // appbar
        Text(
          "Actuators Details",
          style: TextStyle(
            color: AppColors.home_screen_title_alarm_color,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        CustomDivider(),
        //actuators cards
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              children: [MotorDetails(), BeltDriverDetails(), PumpDetails()],
            ),
          ),
        ),
      ],
    );
  }
}
