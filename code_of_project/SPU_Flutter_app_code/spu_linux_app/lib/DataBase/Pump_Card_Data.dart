// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

class Pump {
  final String status;
  // ignore: non_constant_identifier_names
  final String Predicted_fault;
  // ignore: non_constant_identifier_names
  final int Health;
  // ignore: non_constant_identifier_names
  final int Temperature;
  // ignore: non_constant_identifier_names
  final double Pressure_In;
  // ignore: non_constant_identifier_names
  final double Flow_Rate;

  Pump({
    // ignore: non_constant_identifier_names
    required this.Predicted_fault,
    // ignore: non_constant_identifier_names
    required this.status,
    // ignore: non_constant_identifier_names
    required this.Health,
    // ignore: non_constant_identifier_names
    required this.Temperature,
    // ignore: non_constant_identifier_names
    required this.Pressure_In,
    // ignore: non_constant_identifier_names
    required this.Flow_Rate,
  });

  factory Pump.fromJson(Map<String, dynamic> json) {
    final pump = json["Actuators"]?['Pump'] as Map<String, dynamic>? ?? {};
    final sensors =
        json["Actuators"]?['Pump']?["Sensors"] as Map<String, dynamic>? ?? {};
    return Pump(
      Predicted_fault: (pump['Predicted_fault'] ?? "None"),

      status: pump['status'] ?? "None",

      Health: (pump['Health'] as num?)?.toInt() ?? 0,

      Pressure_In: (sensors['Pressure_In'] as num?)?.toDouble() ?? 0.0,

      Flow_Rate: (sensors['Flow_Rate'] as num?)?.toDouble() ?? 0.0,

      Temperature: (sensors['Temperature'] as num?)?.toInt() ?? 0,
    );
  }
}

// ignore: non_constant_identifier_names
Pump none_pump = Pump(
  Predicted_fault: "None",
  status: "None",
  Health: 0,
  Temperature: 0,
  Pressure_In: 0,
  Flow_Rate: 0,
);
Future<Pump> loadPumpFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return none_pump;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      throw Exception("File is empty");
    }

    final jsonResult = jsonDecode(data);

    return Pump.fromJson(jsonResult);
  } catch (e) {
    return none_pump;
  }
}
