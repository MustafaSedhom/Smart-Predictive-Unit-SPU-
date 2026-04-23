import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/Data_Type/Alarm_Data.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomListViewContainer extends StatelessWidget {
  final AlarmData alarm;

  CustomListViewContainer({required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),

        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 5, offset: Offset(1, 1)),
        ],
      ),
      child: Row(
        children: [
          // Icons
          SimpleShadow(
            opacity: 0.9,
            color: AppColors.Drawer_logo_text_color,
            offset: Offset(2, 2),
            sigma: 10,
            child: Image.asset(
              alarm.Icon,
              width: 50,
              height: 50,
              color: AppColors.Drawer_logo_text_color,
            ),
          ),
          Gap(15),
          // problem text and icons and value
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                alarm.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5),
              Row(
                children: [
                  Icon(alarm.Problem_Icon, size: 30, color: Colors.orange),
                  Gap(10),
                  Text(
                    alarm.value,
                    style: TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          // time and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                alarm.Date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5),
              Text(
                alarm.Time,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
