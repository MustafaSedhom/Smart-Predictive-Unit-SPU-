import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/json_file_path.dart';

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

  factory GearSetting.fromJson(Map<String, dynamic> json) {
    final gearSettingData = json["Gear_Setting"] as Map<String, dynamic>? ?? {};
    return GearSetting(
      Big_Gear: (gearSettingData['Big_Gear'] as num?)?.toDouble() ?? 0,

      Small_Gear: (gearSettingData['Small_Gear'] as num?)?.toDouble() ?? 0,

      Gear_setting_unit:
          (gearSettingData['Gear_Setting_Unit'])?.toString() ?? "mm",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "Gear_Setting": {
        "Big_Gear": Big_Gear,
        "Small_Gear": Small_Gear,
        "Gear_Setting_Unit": Gear_setting_unit,
      },
    };
  }
}

// ignore: non_constant_identifier_names
GearSetting none_system_data = GearSetting(
  Big_Gear: 0.0,
  Small_Gear: 0.0,
  Gear_setting_unit: "mm",
);
Future<GearSetting> loadGearSettingFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return none_system_data;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      throw Exception("File is empty");
    }

    final jsonResult = jsonDecode(data);

    return GearSetting.fromJson(jsonResult);
  } catch (e) {
    return none_system_data;
  }
}

Future<void> saveGearSettingToFile(GearSetting gear) async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    Map<String, dynamic> jsonData = {};

    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        jsonData = jsonDecode(content);
      }
    }

    jsonData["Gear_Setting"] = gear.toJson()["Gear_Setting"];

    await file.writeAsString(jsonEncode(jsonData), flush: true);
    // ignore: empty_catches
  } catch (e) {}
}
