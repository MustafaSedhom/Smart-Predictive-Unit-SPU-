// SPU Linux App
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';
import 'package:spu_linux_app/call_all_screens.dart';
// start the app
Future<void> initApp() async {
  final prefs = await SharedPreferences.getInstance();
  String? path = prefs.getString("file_path");

  if (path != null) {
    JsonFilePath.path = path;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(SPU_Linux_APP());
}