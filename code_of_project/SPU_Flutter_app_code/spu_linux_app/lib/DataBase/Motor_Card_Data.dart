// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

class Motor {
  final String status;
  // ignore: non_constant_identifier_names
  final int Predicted_fault;
  // ignore: non_constant_identifier_names
  final int Health;
  // ignore: non_constant_identifier_names
  final int Temperature;
  // ignore: non_constant_identifier_names
  final double Vibration;
  // ignore: non_constant_identifier_names
  final double Current;

  Motor({
    // ignore: non_constant_identifier_names
    required this.Predicted_fault,
    // ignore: non_constant_identifier_names
    required this.status,
    // ignore: non_constant_identifier_names
    required this.Health,
    // ignore: non_constant_identifier_names
    required this.Temperature,
    // ignore: non_constant_identifier_names
    required this.Vibration,
    // ignore: non_constant_identifier_names
    required this.Current,
  });

  factory Motor.fromJson(Map<String, dynamic> json) {
    final motor = json["Actuators"]?['Motor'] as Map<String, dynamic>? ?? {};
    final sensors =
        json["Actuators"]?['Motor']?["Sensors"] as Map<String, dynamic>? ?? {};

    return Motor(
      Predicted_fault: (motor['Predicted_fault'] as num?)?.toInt() ?? 0,
      status: motor['status'] ?? "None",
      Health: (motor['Health'] as num?)?.toInt() ?? 0,
      Temperature: (sensors['Temperature'] as num?)?.toInt() ?? 0,
      Vibration: (sensors['Vibration'] as num?)?.toDouble() ?? 0.0,
      Current: (sensors['Current'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

Future<Motor> loadMotorFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

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

    final data = await file.readAsString();

    if (data.isEmpty) {
      throw Exception("File is empty");
    }

    final jsonResult = jsonDecode(data);

    return Motor.fromJson(jsonResult);
  } catch (e) {
    return Motor(
      Predicted_fault: 0,
      status: "None",
      Health: 0,
      Temperature: 0,
      Vibration: 0,
      Current: 0,
    );
  }
}
