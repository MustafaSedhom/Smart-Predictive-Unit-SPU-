// SPU Linux App
// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/call_all_screens.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

// start the app
Future<void> initApp() async {
  final prefs = await SharedPreferences.getInstance();
  String? path = prefs.getString("file_path");

  if (path != null) {
    FilePaths.json_path = path;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1024, 600),
    minimumSize: Size(800, 480),
    center: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setFullScreen(true);
  });
  await initApp();
  runApp(SPU_Linux_APP());
}
