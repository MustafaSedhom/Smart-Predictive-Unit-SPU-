// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

class Motor {
  final String status;
  final int Predicted_fault;
  final int Health;
  final int Temperature;
  final double Vibration;
  final double Current;

  Motor({
    required this.Predicted_fault,
    required this.status,
    required this.Health,
    required this.Temperature,
    required this.Vibration,
    required this.Current,
  });

  factory Motor.fromJson(Map<String, dynamic> json) {
    return Motor(
      Predicted_fault: (json['Predicted_fault'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? "unknown",
      Health: (json['Health'] as num?)?.toInt() ?? 0,
      Temperature: (json['Sensors']['Temperature'] as num?)?.toInt() ?? 0,
      Vibration: (json['Sensors']['Vibration'] as num?)?.toDouble() ?? 0.0,
      Current: (json['Sensors']['Current'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

Future<Motor> loadMotorFromFile() async {
  final file = File(JsonFilePath.path);
  if (!await file.exists()) {
    return Motor(
      Predicted_fault: 0,
      status: "",
      Health: 0,
      Temperature: 0,
      Vibration: 0,
      Current: 0,
    );
  }
  String data = await file.readAsString();
  final jsonResult = jsonDecode(data);
  final motorJson = jsonResult['Actuators']['Motor'];
  return Motor.fromJson(motorJson);
}
