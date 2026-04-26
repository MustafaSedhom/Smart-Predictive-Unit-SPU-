// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:io';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

class AlertsData {
  final int count;
  final List<AlertsListData> alerts;

  AlertsData({required this.count, required this.alerts});

  factory AlertsData.fromJson(Map<String, dynamic> json) {
    final alertsJson = json["Alerts"] as Map<String, dynamic>? ?? {};
    final list = alertsJson['Alert_List'] as List<dynamic>? ?? [];

    final alertsList = list.map((e) => AlertsListData.fromJson(e)).toList();

    return AlertsData(
      count:
          (alertsJson['List_item_count'] as num?)?.toInt() ?? alertsList.length,
      alerts: alertsList,
    );
  }
}

class AlertsListData {
  final int id;
  final String device;
  final String type;
  final String message;
  final String level;
  final double value;
  final String uint;
  final DateTime timestamp;
  final String period_name;

  AlertsListData({
    required this.id,
    required this.device,
    required this.type,
    required this.message,
    required this.level,
    required this.value,
    required this.timestamp,
    required this.uint,
    required this.period_name,
  });

  factory AlertsListData.fromJson(Map<String, dynamic> json) {
    return AlertsListData(
      id: (json['id'] as num).toInt(),
      device: json['device'] ?? "",
      type: json['type'] ?? "",
      message: json['message'] ?? "",
      level: json['level'] ?? "low",
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.tryParse(json['timestamp'] ?? "") ?? DateTime.now(),
      uint: json['uint'] ?? "",
      period_name: json['period_name'] ?? "",
    );
  }
}

AlertsListData none_alert_list_data = AlertsListData(
  id: 0,
  device: "none",
  type: "None",
  message: "msg",
  level: "Low",
  value: 0,
  timestamp: DateTime.now(),
  uint: 'none',
  period_name: 'none',
);
AlertsData none_alert_data = AlertsData(count: 0, alerts: []);
List<AlertsListData> parseAlertsList(List<dynamic> list) {
  return list.map((e) => AlertsListData.fromJson(e)).toList();
}

// load file
Future<AlertsData> loadAlertsDataFromFile() async {
  try {
    final path = JsonFilePath.path;

    if (path == null || path.isEmpty) {
      return none_alert_data;
    }

    final file = File(path);

    if (!await file.exists()) return none_alert_data;

    final data = await file.readAsString();

    if (data.isEmpty) return none_alert_data;

    final jsonResult = jsonDecode(data);

    return AlertsData.fromJson(jsonResult);
  } catch (e) {
    return none_alert_data;
  }
}

Future<void> clearAlerts() async {
  final path = JsonFilePath.path;

  if (path == null || path.isEmpty) return;

  final file = File(path);

  if (!await file.exists()) return;

  final data = await file.readAsString();
  if (data.isEmpty) return;

  final jsonResult = jsonDecode(data);

  jsonResult["Alerts"]["Alert_List"] = [];
  jsonResult["Alerts"]["List_item_count"] = 0;

  await file.writeAsString(jsonEncode(jsonResult));
}
