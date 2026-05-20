// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////

class PumpValues {
  double pressure_in_min;
  double pressure_in_normal;
  double pressure_in_max;

  double flow_rate_min;
  double flow_rate_normal;
  double flow_rate_max;

  double temperature_min;
  double temperature_normal;
  double temperature_max;

  //////////////////////////////////////////////////////////
  /// CONSTRUCTOR

  PumpValues({
    required this.pressure_in_min,
    required this.pressure_in_normal,
    required this.pressure_in_max,

    required this.flow_rate_min,
    required this.flow_rate_normal,
    required this.flow_rate_max,

    required this.temperature_min,
    required this.temperature_normal,
    required this.temperature_max,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory PumpValues.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    // Settings

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Min Normal Max Values

    final values =
        settings["min_normal_max_values"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Pump

    final pump = values["Pump"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Pressure In

    final pressureIn = pump["Pressure_In"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Flow Rate

    final flowRate = pump["Flow_Rate"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Temperature

    final temperature = pump["Temperature"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return PumpValues(
      //----------------------------------------------------
      // Pressure In
      pressure_in_min: (pressureIn["min"] ?? 0).toDouble(),

      pressure_in_normal: (pressureIn["normal"] ?? 0).toDouble(),

      pressure_in_max: (pressureIn["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Flow Rate
      flow_rate_min: (flowRate["min"] ?? 0).toDouble(),

      flow_rate_normal: (flowRate["normal"] ?? 0).toDouble(),

      flow_rate_max: (flowRate["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Temperature
      temperature_min: (temperature["min"] ?? 0).toDouble(),

      temperature_normal: (temperature["normal"] ?? 0).toDouble(),

      temperature_max: (temperature["max"] ?? 0).toDouble(),
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "Pressure_In": {
        "min": pressure_in_min,
        "normal": pressure_in_normal,
        "max": pressure_in_max,
      },

      "Flow_Rate": {
        "min": flow_rate_min,
        "normal": flow_rate_normal,
        "max": flow_rate_max,
      },

      "Temperature": {
        "min": temperature_min,
        "normal": temperature_normal,
        "max": temperature_max,
      },
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA
////////////////////////////////////////////////////////////

PumpValues none_pump_values = PumpValues(
  //--------------------------------------------------------
  // Pressure In
  pressure_in_min: 0,
  pressure_in_normal: 0,
  pressure_in_max: 0,

  //--------------------------------------------------------
  // Flow Rate
  flow_rate_min: 0,
  flow_rate_normal: 0,
  flow_rate_max: 0,

  //--------------------------------------------------------
  // Temperature
  temperature_min: 0,
  temperature_normal: 0,
  temperature_max: 0,
);

////////////////////////////////////////////////////////////
/// LOAD DATA FROM FILE
////////////////////////////////////////////////////////////

Future<PumpValues> loadPumpValuesFromFile() async {
  try {
    //------------------------------------------------------
    // Check Path

    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File Path Is Null");
    }

    //------------------------------------------------------
    // File

    final file = File(JsonFilePath.path!);

    //------------------------------------------------------
    // Check Exists

    if (!await file.exists()) {
      return none_pump_values;
    }

    //------------------------------------------------------
    // Read File

    final data = await file.readAsString();

    //------------------------------------------------------
    // Empty File

    if (data.isEmpty) {
      return none_pump_values;
    }

    //------------------------------------------------------
    // Decode Json

    final jsonResult = jsonDecode(data);

    //------------------------------------------------------
    // Return Model

    return PumpValues.fromJson(jsonResult);
  } catch (e) {
    debugPrint("Load Error : $e");

    return none_pump_values;
  }
}

////////////////////////////////////////////////////////////
/// SAVE DATA TO FILE
////////////////////////////////////////////////////////////

Future<void> savePumpValuesToFile(PumpValues pumpData) async {
  try {
    //------------------------------------------------------
    // Check Path

    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File Path Is Null");
    }

    //------------------------------------------------------
    // File

    final file = File(JsonFilePath.path!);

    //------------------------------------------------------
    // Json Data

    Map<String, dynamic> jsonData = {};

    //------------------------------------------------------
    // Read Old File

    if (await file.exists()) {
      final content = await file.readAsString();

      if (content.isNotEmpty) {
        jsonData = jsonDecode(content);
      }
    }

    //------------------------------------------------------
    // Create Settings

    jsonData["Settings"] ??= {};

    //------------------------------------------------------
    // Create min_normal_max_values

    jsonData["Settings"]["min_normal_max_values"] ??= {};

    //------------------------------------------------------
    // Save Pump Data

    jsonData["Settings"]["min_normal_max_values"]["Pump"] = pumpData.toJson();

    //------------------------------------------------------
    // Save File

    await file.writeAsString(
      JsonEncoder.withIndent("  ").convert(jsonData),

      flush: true,
    );

    debugPrint("Saved Successfully");
  } catch (e) {
    debugPrint("Save Error : $e");
  }
}
