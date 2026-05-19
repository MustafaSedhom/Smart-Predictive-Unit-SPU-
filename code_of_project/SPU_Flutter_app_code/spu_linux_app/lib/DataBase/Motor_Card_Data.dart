// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

class Motor {
  final String status;
  // ignore: non_constant_identifier_names
  final String Predicted_fault;
  // ignore: non_constant_identifier_names
  final int Health;
  // ignore: non_constant_identifier_names
  final int Temperature;
  // ignore: non_constant_identifier_names
  final double Vibration;
  // ignore: non_constant_identifier_names
  final double Current;
  // ignore: non_constant_identifier_names
  final double Current_p1;
  // ignore: non_constant_identifier_names
  final double Current_p2;
  // ignore: non_constant_identifier_names
  final double Current_p3;
  // ignore: non_constant_identifier_names
  final double Volt_p1;
  // ignore: non_constant_identifier_names
  final double Volt_p2;
  // ignore: non_constant_identifier_names
  final double Volt_p3;

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
    required this.Current_p1,
    required this.Current_p2,
    required this.Current_p3,
    required this.Volt_p1,
    required this.Volt_p2,
    required this.Volt_p3,
  });

  factory Motor.fromJson(Map<String, dynamic> json) {
    final motor = json["Actuators"]?['Motor'] as Map<String, dynamic>? ?? {};
    final sensors =
        json["Actuators"]?['Motor']?["Sensors"] as Map<String, dynamic>? ?? {};

    return Motor(
      Predicted_fault: (motor['Predicted_fault'] ?? "None"),
      status: motor['status'] ?? "None",
      Health: (motor['Health'] as num?)?.toInt() ?? 0,
      Temperature: (sensors['Temperature'] as num?)?.toInt() ?? 0,
      Vibration: (sensors['Vibration'] as num?)?.toDouble() ?? 0.0,
      Current: (sensors['Current'] as num?)?.toDouble() ?? 0.0,
      Current_p1: sensors['Current_p1'],
      Current_p2: sensors['Current_p2'],
      Current_p3: sensors['Current_p3'],
      Volt_p1: sensors['volt_p1'],
      Volt_p2: sensors['volt_p2'],
      Volt_p3: sensors['volt_p3'],
    );
  }
}

// ignore: non_constant_identifier_names
Motor none_motor = Motor(
  Predicted_fault: "None",
  status: "None",
  Health: 0,
  Temperature: 0,
  Vibration: 0,
  Current: 0,
  Current_p1: 0.0,
  Current_p2: 0.0,
  Current_p3: 0.0,
  Volt_p1: 0.0,
  Volt_p2: 0.0,
  Volt_p3: 0.0,
);
Future<Motor> loadMotorFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return none_motor;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      throw Exception("File is empty");
    }

    final jsonResult = jsonDecode(data);

    return Motor.fromJson(jsonResult);
  } catch (e) {
    return none_motor;
  }
}
