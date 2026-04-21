import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/Data_Type/Alarm_Data.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/widgets/Custom_list_view_container.dart';

class AlarmScreen extends StatelessWidget {
  AlarmScreen({super.key});
  // ignore: non_constant_identifier_names
  final List<AlarmData> alarm_list = [
    AlarmData(
      title: "Motor",
      Icon: AppIcons.motor_Icon,
      Problem_Icon: Icons.thermostat,
      Date: "22 / 02 / 2006",
      Time: "11 : 08 : 57",
      value: "12 °C",
    ),
    AlarmData(
      title: "Belt Driver",
      Icon: AppIcons.motor_belt_Icon,
      Problem_Icon: Icons.graphic_eq,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "5.4 m/s\u00B2",
    ),
    AlarmData(
      title: "Motor",
      Icon: AppIcons.motor_Icon,
      Problem_Icon: Icons.bolt,
      Date: "22 / 02 / 2006",
      Time: "11 : 03 : 01",
      value: "100 A",
    ),
    AlarmData(
      title: "Motor",
      Icon: AppIcons.motor_Icon,
      Problem_Icon: Icons.graphic_eq,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "5.4 m/s\u00B2",
    ),
    AlarmData(
      title: "Belt Driver",
      Icon: AppIcons.motor_belt_Icon,
      Problem_Icon: Icons.graphic_eq,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "5.4 m/s\u00B2",
    ),
    AlarmData(
      title: "Belt Driver",
      Icon: AppIcons.motor_pump_Icon,
      Problem_Icon: Icons.thermostat,
      Date: "22 / 02 / 2006",
      Time: "11 : 01 : 13",
      value: "78 °C",
    ),
    // {"title": "Motor", "value": "Running", "icon": Icons.settings},
    // {"title": "Temperature", "value": "32°C", "icon": Icons.thermostat},
    // {"title": "Vibration", "value": "1.2 mm/s", "icon": Icons.graphic_eq},
    // {"title": "Motor", "value": "Running", "icon": Icons.settings},
    // {"title": "Temperature", "value": "32°C", "icon": Icons.thermostat},
    // {"title": "Vibration", "value": "1.2 mm/s", "icon": Icons.graphic_eq},
    // {"title": "Motor", "value": "Running", "icon": Icons.settings},
    // {"title": "Temperature", "value": "32°C", "icon": Icons.thermostat},
    // {"title": "Vibration", "value": "1.2 mm/s", "icon": Icons.graphic_eq},
    // {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
    // {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
    // {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
    // {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "Last Alarms",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(5),
          // ListView Sensors
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: alarm_list.length,
                itemBuilder: (context, index) {
                  return CustomListViewContainer(alarm: alarm_list[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
