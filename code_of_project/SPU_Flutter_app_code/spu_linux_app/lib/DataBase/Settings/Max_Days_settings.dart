// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/File_Paths.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////

class MaxDaysSettings {
  String Motor_Max_Normal_Days;
  String Pump_Max_Normal_Days;
  String Belt_Max_Normal_Days;
  MaxDaysSettings({
    required this.Motor_Max_Normal_Days,
    required this.Belt_Max_Normal_Days,
    required this.Pump_Max_Normal_Days,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory MaxDaysSettings.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    // Settings

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Time Date Analysis

    final Days = settings["max_Days_if_normal"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return MaxDaysSettings(
      Motor_Max_Normal_Days: Days["Motor"] ?? "",

      Pump_Max_Normal_Days: Days["Belt_Driver"] ?? "",
      Belt_Max_Normal_Days: Days["Pump"] ?? "",
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "Motor": Motor_Max_Normal_Days,
      "Belt_Driver": Belt_Max_Normal_Days,
      "Pump": Pump_Max_Normal_Days,
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA
////////////////////////////////////////////////////////////

MaxDaysSettings none_system_data = MaxDaysSettings(
  Motor_Max_Normal_Days: 'NONE',
  Belt_Max_Normal_Days: 'NONE',
  Pump_Max_Normal_Days: 'NONE',
);

////////////////////////////////////////////////////////////
/// LOAD DATA FROM FILE
////////////////////////////////////////////////////////////

Future<MaxDaysSettings> loadMaxDaysSettingsFromFile() async {
  try {
    //------------------------------------------------------
    // Check Path

    if (FilePaths.json_path == null || FilePaths.json_path!.isEmpty) {
      throw Exception("File Path Is Null");
    }

    //------------------------------------------------------
    // File

    final file = File(FilePaths.json_path!);

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

    return MaxDaysSettings.fromJson(jsonResult);
  } catch (e) {
    debugPrint("Load Error : $e");

    return none_system_data;
  }
}

////////////////////////////////////////////////////////////
/// SAVE DATA TO FILE
////////////////////////////////////////////////////////////

Future<void> saveMaxDaysSettingsToFile(MaxDaysSettings timeData) async {
  try {
    //------------------------------------------------------
    // Check Path

    if (FilePaths.json_path == null || FilePaths.json_path!.isEmpty) {
      throw Exception("File Path Is Null");
    }

    //------------------------------------------------------
    // File

    final file = File(FilePaths.json_path!);

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
    // Save Time Date Analysis

    jsonData["Settings"]["max_Days_if_normal"] = timeData.toJson();

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
