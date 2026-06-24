// SPU Linux App
// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/Providers/machine_provider.dart';
import 'package:spu_linux_app/call_all_screens.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

// start the app
Future<void> initApp() async {
  final prefs = await SharedPreferences.getInstance();

  FilePaths.json_path = prefs.getString("json") ?? "";
  FilePaths.Ac_motor_last_Data_path = prefs.getString("motor") ?? "";
  FilePaths.Dc_motor_last_Data_path = prefs.getString("pump") ?? "";
  FilePaths.belt_last_Data_path = prefs.getString("belt") ?? "";
  FilePaths.health_last_Data_path = prefs.getString("health") ?? "";
  FilePaths.alarm_last_Data_path = prefs.getString("alarm") ?? "";
}

void main() async {
  // control the app window
  //////////////////////////////////////////////////////////////////////////////////////////////
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 Hive init
  await Hive.initFlutter();
  await Hive.openBox('machinesBox');
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1024, 600),
    minimumSize: Size(800, 480),
    center: true,
    fullScreen: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setFullScreen(true);
  });
  //////////////////////////////////////////////////////////////////////////////////////////////
  await initApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = MachineProvider();
            provider.initStorage();
            return provider;
          },
        ),
      ],
      child: const SPU_Linux_APP(),
    ),
  );
}
