// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

class BeltDriver {
  final String status;
  // ignore: non_constant_identifier_names
  final int Predicted_fault;
  // ignore: non_constant_identifier_names
  final int Health;
  // ignore: non_constant_identifier_names
  final int Tension;
  // ignore: non_constant_identifier_names
  final double Alignment;
  // ignore: non_constant_identifier_names
  final int Speed;

  BeltDriver({
    // ignore: non_constant_identifier_names
    required this.Predicted_fault,
    // ignore: non_constant_identifier_names
    required this.status,
    // ignore: non_constant_identifier_names
    required this.Health,
    // ignore: non_constant_identifier_names
    required this.Tension,
    required this.Alignment,
    required this.Speed,
  });

  factory BeltDriver.fromJson(Map<String, dynamic> json) {
    return BeltDriver(
      Predicted_fault: (json['Predicted_fault'] as num?)?.toInt() ?? 0,
      status: json['status'] ?? "unknown",
      Health: (json['Health'] as num?)?.toInt() ?? 0,

      Tension: (json['Sensors']['Tension'] as num?)?.toInt() ?? 0,
      Alignment: (json['Sensors']['Alignment'] as num?)?.toDouble() ?? 0.0,
      Speed: (json['Sensors']['Speed'] as num?)?.toInt() ?? 0,
    );
  }
}
Future<BeltDriver> loadBeltDriverFromFile() async {
  final file = File(JsonFilePath.path);
    if (!await file.exists()) {
    return BeltDriver(
      Predicted_fault: 0,
      status: "",
      Health: 0, Tension: 0, Alignment: 0, Speed: 0,

    );
  }
  String data = await file.readAsString();
  final jsonResult = jsonDecode(data);
  final motorJson = jsonResult['Actuators']['Belt_Driver'];
  return BeltDriver.fromJson(motorJson);
}
