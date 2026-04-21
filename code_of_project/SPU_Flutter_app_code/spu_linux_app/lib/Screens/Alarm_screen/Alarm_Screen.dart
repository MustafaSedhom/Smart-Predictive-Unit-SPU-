import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(item["icon"], size: 30, color: Colors.green),
                const SizedBox(width: 15),

                /// TEXTS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item["value"],
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                /// STATUS ICON
                Icon(Icons.circle, color: Colors.green, size: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}
