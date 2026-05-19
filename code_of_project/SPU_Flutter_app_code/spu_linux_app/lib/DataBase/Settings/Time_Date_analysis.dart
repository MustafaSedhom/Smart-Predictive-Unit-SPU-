// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

////////////////////////////////////////////////////////////
/// MODEL
////////////////////////////////////////////////////////////

class TimeDateAnalysis {
  String TimeDate_Start;
  String TimeDate_End;

  TimeDateAnalysis({required this.TimeDate_Start, required this.TimeDate_End});

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory TimeDateAnalysis.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    // Settings

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    // Time Date Analysis

    final timeData =
        settings["Time_Date_Analysis"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return TimeDateAnalysis(
      TimeDate_Start: timeData["start_time_analysis"] ?? "",

      TimeDate_End: timeData["end_time_analysis"] ?? "",
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "start_time_analysis": TimeDate_Start,
      "end_time_analysis": TimeDate_End,
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA
////////////////////////////////////////////////////////////

TimeDateAnalysis none_system_data = TimeDateAnalysis(
  TimeDate_Start: "",
  TimeDate_End: "",
);

////////////////////////////////////////////////////////////
/// LOAD DATA FROM FILE
////////////////////////////////////////////////////////////

Future<TimeDateAnalysis> loadTimeDateAnalysisFromFile() async {
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

    return TimeDateAnalysis.fromJson(jsonResult);
  } catch (e) {
    debugPrint("Load Error : $e");

    return none_system_data;
  }
}

////////////////////////////////////////////////////////////
/// SAVE DATA TO FILE
////////////////////////////////////////////////////////////

Future<void> saveTimeDateAnalysisToFile(TimeDateAnalysis timeData) async {
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
    // Save Time Date Analysis

    jsonData["Settings"]["Time_Date_Analysis"] = timeData.toJson();

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