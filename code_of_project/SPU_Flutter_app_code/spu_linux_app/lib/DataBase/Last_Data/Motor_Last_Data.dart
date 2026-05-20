// ignore_for_file: file_names

import 'dart:io';
import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_result.dart';


class MotorFileReader {
  static Future<FileResult> readMotorFile() async {
    try {
      //--------------------------------------------------
      /// GET PATH
      final path = FilePaths.motor_last_Data_path;

      //--------------------------------------------------
      /// CHECK PATH
      if (path == null || path.isEmpty) {
        return FileResult(
          hasData: false,
          message: "No Data (Empty Path)",
          rawData: "",
        );
      }

      //--------------------------------------------------
      /// FILE
      final file = File(path);

      //--------------------------------------------------
      /// CHECK EXIST
      if (!await file.exists()) {
        return FileResult(
          hasData: false,
          message: "No Data (File Not Found)",
          rawData: "",
        );
      }

      //--------------------------------------------------
      /// READ FILE
      final data = await file.readAsString();

      if (data.isEmpty) {
        return FileResult(
          hasData: false,
          message: "No Data (Empty File)",
          rawData: "",
        );
      }

      //--------------------------------------------------
      /// SUCCESS
      return FileResult(
        hasData: true,
        message: "Data Loaded Successfully",
        rawData: data,
      );
    } catch (e) {
      return FileResult(hasData: false, message: "Error: $e", rawData: "");
    }
  }
}
