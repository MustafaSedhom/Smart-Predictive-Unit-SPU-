// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////

class MotorValues {
  double temp_normal;
  double temp_max;
  double temp_min;

  double vibration_normal;
  double vibration_max;
  double vibration_min;

  double current_normal;
  double current_max;
  double current_min;

  double volt_normal;
  double volt_max;
  double volt_min;

  //////////////////////////////////////////////////////////
  /// CONSTRUCTOR

  MotorValues({
    required this.temp_normal,
    required this.temp_max,
    required this.temp_min,

    required this.vibration_normal,
    required this.vibration_max,
    required this.vibration_min,

    required this.current_normal,
    required this.current_max,
    required this.current_min,

    required this.volt_normal,
    required this.volt_max,
    required this.volt_min,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory MotorValues.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    // Settings

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Min Normal Max Values

    final values =
        settings["min_normal_max_values"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Motor

    final motor = values["Motor"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Temperature

    final temperature = motor["Temperature"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Vibration

    final vibration = motor["Vibration"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Current

    final current = motor["Current"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Volt

    final volt = motor["Volt"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return MotorValues(
      //----------------------------------------------------
      // Temperature
      temp_min: (temperature["min"] ?? 0).toDouble(),

      temp_normal: (temperature["normal"] ?? 0).toDouble(),

      temp_max: (temperature["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Vibration
      vibration_min: (vibration["min"] ?? 0).toDouble(),

      vibration_normal: (vibration["normal"] ?? 0).toDouble(),

      vibration_max: (vibration["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Current
      current_min: (current["min"] ?? 0).toDouble(),

      current_normal: (current["normal"] ?? 0).toDouble(),

      current_max: (current["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Volt
      volt_min: (volt["min"] ?? 0).toDouble(),

      volt_normal: (volt["normal"] ?? 0).toDouble(),

      volt_max: (volt["max"] ?? 0).toDouble(),
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "Temperature": {"min": temp_min, "normal": temp_normal, "max": temp_max},

      "Vibration": {
        "min": vibration_min,
        "normal": vibration_normal,
        "max": vibration_max,
      },

      "Current": {
        "min": current_min,
        "normal": current_normal,
        "max": current_max,
      },

      "Volt": {"min": volt_min, "normal": volt_normal, "max": volt_max},
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA
////////////////////////////////////////////////////////////

MotorValues none_motor_values = MotorValues(
  //--------------------------------------------------------
  // Temperature
  temp_min: 0,
  temp_normal: 0,
  temp_max: 0,

  //--------------------------------------------------------
  // Vibration
  vibration_min: 0,
  vibration_normal: 0,
  vibration_max: 0,

  //--------------------------------------------------------
  // Current
  current_min: 0,
  current_normal: 0,
  current_max: 0,

  //--------------------------------------------------------
  // Volt
  volt_min: 0,
  volt_normal: 0,
  volt_max: 0,
);

////////////////////////////////////////////////////////////
/// LOAD DATA FROM FILE
////////////////////////////////////////////////////////////

Future<MotorValues> loadMotorValuesFromFile() async {
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
      return none_motor_values;
    }

    //------------------------------------------------------
    // Read File

    final data = await file.readAsString();

    //------------------------------------------------------
    // Empty File

    if (data.isEmpty) {
      return none_motor_values;
    }

    //------------------------------------------------------
    // Decode Json

    final jsonResult = jsonDecode(data);

    //------------------------------------------------------
    // Return Model

    return MotorValues.fromJson(jsonResult);
  } catch (e) {
    debugPrint("Load Error : $e");

    return none_motor_values;
  }
}

////////////////////////////////////////////////////////////
/// SAVE DATA TO FILE
////////////////////////////////////////////////////////////

Future<void> saveMotorValuesToFile(MotorValues motorData) async {
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
    // Save Motor Data

    jsonData["Settings"]["min_normal_max_values"]["Motor"] = motorData.toJson();

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
