import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/widgets/Custom_list_view_container.dart';

class AlarmScreen extends StatelessWidget {
  AlarmScreen({super.key});
  final List<Map<String, dynamic>> items = [
    {"title": "Motor", "value": "Running", "icon": Icons.settings},
    {"title": "Temperature", "value": "32°C", "icon": Icons.thermostat},
    {"title": "Vibration", "value": "1.2 mm/s", "icon": Icons.graphic_eq},
    {"title": "Motor", "value": "Running", "icon": Icons.settings},
    {"title": "Temperature", "value": "32°C", "icon": Icons.thermostat},
    {"title": "Vibration", "value": "1.2 mm/s", "icon": Icons.graphic_eq},
    {"title": "Motor", "value": "Running", "icon": Icons.settings},
    {"title": "Temperature", "value": "32°C", "icon": Icons.thermostat},
    {"title": "Vibration", "value": "1.2 mm/s", "icon": Icons.graphic_eq},
    {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
    {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
    {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
    {"title": "Current", "value": "1.4 A", "icon": Icons.bolt},
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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return CustomListViewContainer(
                    icon: item["icon"],
                    title: item["title"],
                    value: item["value"],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
