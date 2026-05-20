// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////

class MotorHealthThreshold {
  int warning_threshold;
  int alert_threshold;

  MotorHealthThreshold({
    required this.alert_threshold,
    required this.warning_threshold,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory MotorHealthThreshold.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    // Settings

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Health Thresholds

    final healthThresholds =
        settings["Health_Thresholds"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Motor

    final threshold = healthThresholds["Motor"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return MotorHealthThreshold(
      alert_threshold: threshold['alert'] ?? 0,
      warning_threshold: threshold["warning"] ?? 0,
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {"warning": warning_threshold, "alert": alert_threshold};
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA
////////////////////////////////////////////////////////////

MotorHealthThreshold none_system_data = MotorHealthThreshold(
  alert_threshold: 0,
  warning_threshold: 0,
);

////////////////////////////////////////////////////////////
/// LOAD DATA FROM FILE
////////////////////////////////////////////////////////////

Future<MotorHealthThreshold> loadMotorHealthThresholdFromFile() async {
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
      return none_system_data;
    }

    //------------------------------------------------------
    // Read File

    final data = await file.readAsString();

    //------------------------------------------------------
    // Empty File

    if (data.isEmpty) {
      return none_system_data;
    }

    //------------------------------------------------------
    // Decode Json

    final jsonResult = jsonDecode(data);

    //------------------------------------------------------
    // Return Model

    return MotorHealthThreshold.fromJson(jsonResult);
  } catch (e) {
    debugPrint("Load Error : $e");

    return none_system_data;
  }
}

////////////////////////////////////////////////////////////
/// SAVE DATA TO FILE
////////////////////////////////////////////////////////////

Future<void> saveMotorHealthThresholdToFile(
  MotorHealthThreshold timeData,
) async {
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
    // Create Health Thresholds

    jsonData["Settings"]["Health_Thresholds"] ??= {};

    //------------------------------------------------------
    // Save Motor Data

    jsonData["Settings"]["Health_Thresholds"]["Motor"] = timeData.toJson();

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
