// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/DataBase/Alerts_data.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomListViewContainer extends StatelessWidget {
  final AlertsListData alarm;

  CustomListViewContainer({required this.alarm});
  List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  String alert_card_icon(String device) {
    String my_device = device.toUpperCase();
    if (my_device == "MOTOR") {
      return AppIcons.motor_Icon;
    } else if (my_device == "BELT" ||
        my_device == "BELT_DRIVER" ||
        my_device == "BELT DRIVER") {
      return AppIcons.motor_belt_Icon;
    } else if (my_device == "PUMP") {
      return AppIcons.motor_pump_Icon;
    } else if (my_device == "DC" ||
        my_device == "DC MOTOR" ||
        my_device == "DC_MOTOR") {
      return AppIcons.motor_Icon;
    }
    return AppIcons.motor_Icon;
  }

  IconData alert_problem_icon(String problem) {
    String my_problem = problem.toUpperCase();
    if (my_problem == "TEMP" || my_problem == "TEMPERATURE") {
      return Icons.thermostat_rounded;
    } else if (my_problem == "CURRENT" || my_problem == "VOLT") {
      return Icons.bolt;
    } else if (my_problem == "NOISE") {
      return Icons.graphic_eq;
    } else if (my_problem == "SPEED") {
      return Icons.speed;
    } else if (my_problem == "TENSION") {
      return Icons.compress;
    } else if (my_problem == "ALIGN" || my_problem == "ALIGNMENT") {
      return Icons.straighten;
    } else if (my_problem == "FLOW RATE" || my_problem == "FLOW_RATE") {
      return Icons.waves_rounded;
    } else if (my_problem == "PRESSURE") {
      return Icons.compress;
    }
    return Icons.circle;
  }

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
          Icon(
            (alarm.level.toUpperCase() == "LOW")
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: Colors.blue,
            size: 30,
          ),
          Gap(10),
          SimpleShadow(
            opacity: 0.9,
            color: AppColors.Drawer_logo_text_color,
            offset: Offset(2, 2),
            sigma: 10,
            child: Image.asset(
              alert_card_icon(alarm.device),
              width: 50,
              height: 50,
              color: AppColors.Drawer_logo_text_color,
            ),
          ),
          Gap(15),
          // problem text and icons and value
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                alarm.device.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5),
              Row(
                children: [
                  Icon(
                    alert_problem_icon(alarm.type),
                    size: 30,
                    color: Colors.orange,
                  ),
                  Gap(10),

                  Text(
                    '${alarm.type} : ${alarm.value} ${alarm.uint}',
                    style: TextStyle(color: Colors.orange, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Gap(10),
          // massage
          Expanded(
            child: Text(
              alarm.message,
              style: TextStyle(
                color: AppColors.home_screen_title_alarm_color,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap(10),
          // time and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${alarm.timestamp.hour} : ${alarm.timestamp.minute} : ${alarm.timestamp.second}  ${alarm.period_name.toUpperCase()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5),
              Text(
                '${alarm.timestamp.year} / ${alarm.timestamp.month} / ${alarm.timestamp.day}  ${weekdays[alarm.timestamp.weekday - 1]}',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
