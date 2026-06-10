import 'dart:convert';
import 'dart:io';

import 'package:spu_linux_app/DataBase/File_Paths.dart';

class AdminSettings {
  String Email;
  String Phone;
  AdminSettings({
    required this.Email,
    required this.Phone,
  });

  //////////////////////////////////////////////////////////
  /// FROM JSON

factory AdminSettings.fromJson(Map<String, dynamic> json) {
    final settings = json["Settings"] as Map<String, dynamic>? ?? {};

    final admin = settings["Admin"] as Map<String, dynamic>? ?? {};

    return AdminSettings(
      Email: admin["Email"] ?? "",
      Phone: admin["Phone"] ?? "",
    );
  }

  //////////////////////////////////////////////////////////
  /// TO JSON

  Map<String, dynamic> toJson() {
    return {
      "Email": Email,
      "Phone": Phone,
    };
  }
}

////////////////////////////////////////////////////////////
/// DEFAULT DATA

// ignore: non_constant_identifier_names
AdminSettings none_system_data = AdminSettings(
  Email: "",
  Phone: "",
);

////////////////////////////////////////////////////////////
/// LOAD FROM FILE

Future<AdminSettings> loadAdminSettingsFromFile() async {
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

    return AdminSettings.fromJson(jsonResult);
  } catch (e) {
    return none_system_data;
  }
}

////////////////////////////////////////////////////////////
/// SAVE TO FILE

Future<void> saveAdminSettingsToFile(AdminSettings admin) async {
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
    /// SAVE ADMIN

    jsonData["Settings"]["Admin"] = admin.toJson();

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
