import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/File_Paths.dart';

class GearSetting {
  // ignore: non_constant_identifier_names
  double Big_Gear;

  // ignore: non_constant_identifier_names
  double Small_Gear;

  // ignore: non_constant_identifier_names
  String Gear_setting_unit;

  GearSetting({
    // ignore: non_constant_identifier_names
    required this.Big_Gear,

    // ignore: non_constant_identifier_names
    required this.Small_Gear,

    // ignore: non_constant_identifier_names
    required this.Gear_setting_unit,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

  factory GearSetting.fromJson(Map<String, dynamic> json) {
    //------------------------------------------------------
    /// SETTINGS

    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------
    /// GEAR

    final gear = settings["Gear_Setting"] as Map<String, dynamic>? ?? {};

    //------------------------------------------------------

    return GearSetting(
      Big_Gear: (gear["Big_Gear"] ?? 0).toDouble(),

      Small_Gear: (gear["Small_Gear"] ?? 0).toDouble(),

      Gear_setting_unit: gear["Gear_setting_unit"] ?? "mm",
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "Big_Gear": Big_Gear,

      "Small_Gear": Small_Gear,

      "Gear_setting_unit": Gear_setting_unit,
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA

// ignore: non_constant_identifier_names
GearSetting none_system_data = GearSetting(
  Big_Gear: 0.0,

  Small_Gear: 0.0,

  Gear_setting_unit: "mm",
);

////////////////////////////////////////////////////////////
/// LOAD FROM FILE

Future<GearSetting> loadGearSettingFromFile() async {
  try {
    //------------------------------------------------------
    /// CHECK PATH

    if (FilePaths.json_path == null || FilePaths.json_path!.isEmpty) {
      throw Exception("File path is not set");
    }

    //------------------------------------------------------
    /// FILE

    final file = File(FilePaths.json_path!);

    //------------------------------------------------------
    /// EXISTS

    if (!await file.exists()) {
      return none_system_data;
    }

    //------------------------------------------------------
    /// READ

    final data = await file.readAsString();

    //------------------------------------------------------
    /// EMPTY

    if (data.isEmpty) {
      return none_system_data;
    }

    //------------------------------------------------------
    /// JSON

    final jsonResult = jsonDecode(data);

    //------------------------------------------------------

    return GearSetting.fromJson(jsonResult);
  } catch (e) {
    return none_system_data;
  }
}

////////////////////////////////////////////////////////////
/// SAVE TO FILE

Future<void> saveGearSettingToFile(GearSetting gear) async {
  try {
    //------------------------------------------------------
    /// CHECK PATH

    if (FilePaths.json_path == null || FilePaths.json_path!.isEmpty) {
      throw Exception("File path is not set");
    }

    //------------------------------------------------------
    /// FILE

    final file = File(FilePaths.json_path!);

    //------------------------------------------------------
    /// JSON DATA

    Map<String, dynamic> jsonData = {};

    //------------------------------------------------------
    /// READ OLD FILE

    if (await file.exists()) {
      final content = await file.readAsString();

      if (content.isNotEmpty) {
        jsonData = jsonDecode(content);
      }
    }

    //------------------------------------------------------
    /// SETTINGS

    jsonData["Settings"] ??= {};

    //------------------------------------------------------
    /// SAVE GEAR

    jsonData["Settings"]["Gear_Setting"] = gear.toJson();

    //------------------------------------------------------
    /// WRITE FILE

    await file.writeAsString(
      JsonEncoder.withIndent("  ").convert(jsonData),

      flush: true,
    );
  } catch (e) {
    // ignore
  }
}
