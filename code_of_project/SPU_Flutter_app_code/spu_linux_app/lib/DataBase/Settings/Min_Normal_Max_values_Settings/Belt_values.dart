// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////

class BeltDriverValues {
  double tension_min;
  double tension_normal;
  double tension_max;

  double alignment_min;
  double alignment_normal;
  double alignment_max;

  double speed_min;
  double speed_normal;
  double speed_max;

  //////////////////////////////////////////////////////////
  /// CONSTRUCTOR

  BeltDriverValues({
    required this.tension_min,
    required this.tension_normal,
    required this.tension_max,

    required this.alignment_min,
    required this.alignment_normal,
    required this.alignment_max,

    required this.speed_min,
    required this.speed_normal,
    required this.speed_max,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory BeltDriverValues.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    // Settings

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Min Normal Max Values

    final values =
        settings["min_normal_max_values"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Belt Driver

    final beltDriver = values["Belt_Driver"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Tension

    final tension = beltDriver["Tension"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Alignment

    final alignment = beltDriver["Alignment"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Speed

    final speed = beltDriver["Speed"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return BeltDriverValues(
      //----------------------------------------------------
      // Tension
      tension_min: (tension["min"] ?? 0).toDouble(),

      tension_normal: (tension["normal"] ?? 0).toDouble(),

      tension_max: (tension["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Alignment
      alignment_min: (alignment["min"] ?? 0).toDouble(),

      alignment_normal: (alignment["normal"] ?? 0).toDouble(),

      alignment_max: (alignment["max"] ?? 0).toDouble(),

      //----------------------------------------------------
      // Speed
      speed_min: (speed["min"] ?? 0).toDouble(),

      speed_normal: (speed["normal"] ?? 0).toDouble(),

      speed_max: (speed["max"] ?? 0).toDouble(),
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "Tension": {
        "min": tension_min,
        "normal": tension_normal,
        "max": tension_max,
      },

      "Alignment": {
        "min": alignment_min,
        "normal": alignment_normal,
        "max": alignment_max,
      },

      "Speed": {"min": speed_min, "normal": speed_normal, "max": speed_max},
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA
////////////////////////////////////////////////////////////

BeltDriverValues none_belt_driver_values = BeltDriverValues(
  //----------------------------------------------------
  // Tension
  tension_min: 0,
  tension_normal: 0,
  tension_max: 0,

  //----------------------------------------------------
  // Alignment
  alignment_min: 0,
  alignment_normal: 0,
  alignment_max: 0,

  //----------------------------------------------------
  // Speed
  speed_min: 0,
  speed_normal: 0,
  speed_max: 0,
);

////////////////////////////////////////////////////////////
/// LOAD DATA FROM FILE
////////////////////////////////////////////////////////////

Future<BeltDriverValues> loadBeltDriverValuesFromFile() async {
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
      return none_belt_driver_values;
    }

    //------------------------------------------------------
    // Read File

    final data = await file.readAsString();

    //------------------------------------------------------
    // Empty File

    if (data.isEmpty) {
      return none_belt_driver_values;
    }

    //------------------------------------------------------
    // Decode Json

    final jsonResult = jsonDecode(data);

    //------------------------------------------------------
    // Return Model

    return BeltDriverValues.fromJson(jsonResult);
  } catch (e) {
    debugPrint("Load Error : $e");

    return none_belt_driver_values;
  }
}

////////////////////////////////////////////////////////////
/// SAVE DATA TO FILE
////////////////////////////////////////////////////////////

Future<void> saveBeltDriverValuesToFile(BeltDriverValues beltData) async {
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
    // Save Belt Driver Data

    jsonData["Settings"]["min_normal_max_values"]["Belt_Driver"] = beltData
        .toJson();

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
