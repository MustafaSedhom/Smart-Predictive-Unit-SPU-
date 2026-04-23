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
    // ignore: non_constant_identifier_names
    required this.Alignment,
    // ignore: non_constant_identifier_names
    required this.Speed,
  });

  factory BeltDriver.fromJson(Map<String, dynamic> json) {
    final belt =
        json["Actuators"]?['Belt_Driver'] as Map<String, dynamic>? ?? {};
    final sensors =
        json["Actuators"]?['Belt_Driver']?["Sensors"]
            as Map<String, dynamic>? ??
        {};
    return BeltDriver(
      Predicted_fault: (belt['Predicted_fault'] as num?)?.toInt() ?? 0,
      status: belt['status'] ?? "unknown",
      Health: (belt['Health'] as num?)?.toInt() ?? 0,

      Tension: (sensors['Tension'] as num?)?.toInt() ?? 0,
      Alignment: (sensors['Alignment'] as num?)?.toDouble() ?? 0.0,
      Speed: (sensors['Speed'] as num?)?.toInt() ?? 0,
    );
  }
}

// ignore: non_constant_identifier_names
BeltDriver none_belt_driver = BeltDriver(
  Predicted_fault: 0,
  status: "None",
  Health: 0,
  Tension: 0,
  Alignment: 0,
  Speed: 0,
);
Future<BeltDriver> loadBeltDriverFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return none_belt_driver;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      throw Exception("File is empty");
    }

    final jsonResult = jsonDecode(data);

    return BeltDriver.fromJson(jsonResult);
  } catch (e) {
    return none_belt_driver;
  }
}
