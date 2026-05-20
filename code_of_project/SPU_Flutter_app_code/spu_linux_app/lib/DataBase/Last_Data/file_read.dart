import 'dart:io';
import 'package:spu_linux_app/DataBase/Last_Data/file_result.dart';

class FileReader {
  static Future<FileResult> readFile(String? path) async {
    try {
      // -------------------------
      // 1) Validate path
      if (path == null || path.trim().isEmpty) {
        return FileResult(
          hasData: false,
          message: "No Data (Empty Path)",
          rawData: "",
        );
      }

      final file = File(path);

      // -------------------------
      // 2) Check existence
      final exists = await file.exists();
      if (!exists) {
        return FileResult(
          hasData: false,
          message: "No Data (File Not Found)",
          rawData: "",
        );
      }

      // -------------------------
      // 3) Read file safely
      final data = await file.readAsString();

      if (data.trim().isEmpty) {
        return FileResult(
          hasData: false,
          message: "No Data (Empty File)",
          rawData: "",
        );
      }

      // -------------------------
      // 4) Success
      return FileResult(
        hasData: true,
        message: "Loaded Successfully",
        rawData: data,
      );
    } on FileSystemException catch (e) {
      return FileResult(
        hasData: false,
        message: "File System Error: ${e.message}",
        rawData: "",
      );
    } catch (e) {
      return FileResult(
        hasData: false,
        message: "Unknown Error: $e",
        rawData: "",
      );
    }
  }
}
