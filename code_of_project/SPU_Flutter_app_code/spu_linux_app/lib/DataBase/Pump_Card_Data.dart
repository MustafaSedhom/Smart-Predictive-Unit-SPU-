// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

class Pump {
  final String status;
  // ignore: non_constant_identifier_names
  final int Predicted_fault;
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
    return Pump(
Predicted_fault: (json['Predicted_fault'] as num?)?.toInt() ?? 0,

      status: json['status'] ?? "unknown",

      Health: (json['Health'] as num?)?.toInt() ?? 0,

      Pressure_In: (json['Sensors']['Pressure_In'] as num?)?.toDouble() ?? 0.0,

      Flow_Rate: (json['Sensors']['Flow_Rate'] as num?)?.toDouble() ?? 0.0,

      Temperature: (json['Sensors']['Temperature'] as num?)?.toInt() ?? 0,
    );
  }
}

Future<Pump> loadPumpFromFile() async {
  final file = File(JsonFilePath.path);
    if (!await file.exists()) {
    return Pump(
      Predicted_fault: 0,
      status: "",
      Health: 0,
      Temperature: 0, Pressure_In: 0, Flow_Rate: 0,
    );
  }
  String data = await file.readAsString();
  final jsonResult = jsonDecode(data);
  final motorJson = jsonResult['Actuators']['Pump'];
  return Pump.fromJson(motorJson);
}
