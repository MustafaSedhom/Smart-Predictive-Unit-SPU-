import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_read.dart';
import 'package:spu_linux_app/DataBase/Last_Data/file_result.dart';

class SystemFiles {
  static Future<FileResult> motor() =>
      FileReader.readFile(FilePaths.Ac_motor_last_Data_path);

  static Future<FileResult> pump() =>
      FileReader.readFile(FilePaths.Dc_motor_last_Data_path);

  static Future<FileResult> belt() =>
      FileReader.readFile(FilePaths.belt_last_Data_path);

  static Future<FileResult> alarm() =>
      FileReader.readFile(FilePaths.alarm_last_Data_path);
}
