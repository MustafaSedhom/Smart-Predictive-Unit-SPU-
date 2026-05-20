import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/File_Paths.dart';

class SensorsOnline {
  final int active;
  final int total;

  SensorsOnline({required this.active, required this.total});

  factory SensorsOnline.fromJson(Map<String, dynamic> json) {
    return SensorsOnline(
      active: json['active'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class SystemData {
  final int overallHealth;
  final int activeAlarms;
  final int nextMaintenance;
  final SensorsOnline sensorsOnline;

  SystemData({
    required this.overallHealth,
    required this.activeAlarms,
    required this.nextMaintenance,
    required this.sensorsOnline,
  });

  factory SystemData.fromJson(Map<String, dynamic> json) {
    final overAll = json["Over_All"] as Map<String, dynamic>? ?? {};
    return SystemData(
      overallHealth: (overAll['overall_Health'] as num?)?.toInt() ?? 0,

      activeAlarms: (overAll['Active_Alarms'] as num?)?.toInt() ?? 0,

      nextMaintenance: (overAll['Next_Maintenance'] as num?)?.toInt() ?? 0,

      sensorsOnline: SensorsOnline.fromJson(
        overAll['sensors_online'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

// ignore: non_constant_identifier_names
SystemData none_system_data = SystemData(
  overallHealth: 0,
  activeAlarms: 0,
  nextMaintenance: 0,
  sensorsOnline: SensorsOnline(active: 0, total: 0),
);
Future<SystemData> loadSystemFromFile() async {
  try {
    if (FilePaths.json_path == null || FilePaths.json_path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(FilePaths.json_path!);

    if (!await file.exists()) {
      return none_system_data;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      throw Exception("File is empty");
    }

    final jsonResult = jsonDecode(data);

    return SystemData.fromJson(jsonResult);
  } catch (e) {
    return none_system_data;
  }
}
