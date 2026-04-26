// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomValueSensorCard extends StatelessWidget {
  final String name;
  final String value;
  final String uint;
  const CustomValueSensorCard({
    super.key,
    required this.name,
    required this.value,
    required this.uint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // name
        Text(
          name,
          style: TextStyle(
            color: AppColors.Start_indicator_color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // value and uint
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.blueGrey),
          ),
          child: Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: AppColors.Drawer_text_color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(20),
              Text(
                uint,
                style: TextStyle(
                  color: AppColors.Drawer_text_color.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
