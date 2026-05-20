// ignore_for_file: non_constant_identifier_names

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:spu_linux_app/DataBase/File_Paths.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/widgets/Custom_changes.dart';
import 'package:spu_linux_app/widgets/Custom_app_bar_text_style.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class AdvancedSettingScreen extends StatefulWidget {
  const AdvancedSettingScreen({super.key});

  @override
  State<AdvancedSettingScreen> createState() => _AdvancedSettingScreenState();
}

class _AdvancedSettingScreenState extends State<AdvancedSettingScreen> {
  //////////////////////////////////////////////////////////
  /// CONTROLLERS

  final TextEditingController jsonController = TextEditingController();

  final TextEditingController motorController = TextEditingController();

  final TextEditingController pumpController = TextEditingController();

  final TextEditingController beltController = TextEditingController();

  final TextEditingController healthController = TextEditingController();

  final TextEditingController alarmController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //////////////////////////////////////////////////////////
  /// LOADING STATES

  bool jsonLoading = false;
  bool motorLoading = false;
  bool pumpLoading = false;
  bool beltLoading = false;
  bool healthLoading = false;
  bool alarmLoading = false;
  bool passLoading = false;

  //////////////////////////////////////////////////////////
  /// FILE PICKER

  Future<String?> pickFile(String ext) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: [ext],
    );

    if (result != null) {
      return result.files.first.path;
    }
    return null;
  }

  //////////////////////////////////////////////////////////
  /// SAVE PATH

  Future<void> savePath(String key, String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, path);
  }

  //////////////////////////////////////////////////////////
  /// GET PATH

  Future<String?> getPath(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  //////////////////////////////////////////////////////////
  /// PASSWORD

  Future<void> updatePassword(String pass) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("password", pass);
  }

  //////////////////////////////////////////////////////////
  /// SAVE HELPER

  Future<void> saveFile({
    required String key,
    required String path,
    required VoidCallback onDone,
    required VoidCallback setLoadingOn,
    required VoidCallback setLoadingOff,
  }) async {
    if (path.isEmpty) return;

    setLoadingOn();

    try {
      await savePath(key, path);
      onDone();
    } finally {
      setLoadingOff();
    }
  }

  //////////////////////////////////////////////////////////
  /// INIT

  @override
  void initState() {
    super.initState();
    loadAllPaths();
  }

  Future<void> loadAllPaths() async {
    jsonController.text = await getPath("json") ?? "";
    motorController.text = await getPath("motor") ?? "";
    pumpController.text = await getPath("pump") ?? "";
    beltController.text = await getPath("belt") ?? "";
    healthController.text = await getPath("health") ?? "";
    alarmController.text = await getPath("alarm") ?? "";

    FilePaths.json_path = jsonController.text;
    FilePaths.motor_last_Data_path = motorController.text;
    FilePaths.pump_last_Data_path = pumpController.text;
    FilePaths.belt_last_Data_path = beltController.text;
    FilePaths.health_last_Data_path = healthController.text;
    FilePaths.alarm_last_Data_path = alarmController.text;
  }

  //////////////////////////////////////////////////////////
  /// UI

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const Gap(10),

          Text(
            "Advanced Setting",
            style: CustomAppBarTextStyle.appbar_text_style(),
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// JSON
          CustomChanges(
            controller: jsonController,
            title: "JSON File",
            hint: "Path",
            is_saved: jsonLoading,
            ontap_prefix_icon: () async {
              final path = await pickFile("json");
              if (path != null) {
                setState(() => jsonController.text = path);
              }
            },
            save_operation: () async {
              await saveFile(
                key: "json",
                path: jsonController.text,
                setLoadingOn: () => setState(() => jsonLoading = true),
                setLoadingOff: () => setState(() => jsonLoading = false),
                onDone: () {
                  FilePaths.json_path = jsonController.text;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("JSON Saved ✅")));
                },
              );
            },
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// MOTOR
          CustomChanges(
            controller: motorController,
            title: "Motor CSV",
            hint: "Path",
            is_saved: motorLoading,
            ontap_prefix_icon: () async {
              final path = await pickFile("csv");
              if (path != null) {
                setState(() => motorController.text = path);
              }
            },
            save_operation: () async {
              await saveFile(
                key: "motor",
                path: motorController.text,
                setLoadingOn: () => setState(() => motorLoading = true),
                setLoadingOff: () => setState(() => motorLoading = false),
                onDone: () {
                  FilePaths.motor_last_Data_path = motorController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Motor Saved ✅")),
                  );
                },
              );
            },
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// PUMP
          CustomChanges(
            controller: pumpController,
            title: "Pump CSV",
            hint: "Path",
            is_saved: pumpLoading,
            ontap_prefix_icon: () async {
              final path = await pickFile("csv");
              if (path != null) {
                setState(() => pumpController.text = path);
              }
            },
            save_operation: () async {
              await saveFile(
                key: "pump",
                path: pumpController.text,
                setLoadingOn: () => setState(() => pumpLoading = true),
                setLoadingOff: () => setState(() => pumpLoading = false),
                onDone: () {
                  FilePaths.pump_last_Data_path = pumpController.text;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Pump Saved ✅")));
                },
              );
            },
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// BELT
          CustomChanges(
            controller: beltController,
            title: "Belt CSV",
            hint: "Path",
            is_saved: beltLoading,
            ontap_prefix_icon: () async {
              final path = await pickFile("csv");
              if (path != null) {
                setState(() => beltController.text = path);
              }
            },
            save_operation: () async {
              await saveFile(
                key: "belt",
                path: beltController.text,
                setLoadingOn: () => setState(() => beltLoading = true),
                setLoadingOff: () => setState(() => beltLoading = false),
                onDone: () {
                  FilePaths.belt_last_Data_path = beltController.text;

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Belt Saved ✅")));
                },
              );
            },
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// HEALTH
          CustomChanges(
            controller: healthController,
            title: "Health CSV",
            hint: "Path",
            is_saved: healthLoading,
            ontap_prefix_icon: () async {
              final path = await pickFile("csv");
              if (path != null) {
                setState(() => healthController.text = path);
              }
            },
            save_operation: () async {
              await saveFile(
                key: "health",
                path: healthController.text,
                setLoadingOn: () => setState(() => healthLoading = true),
                setLoadingOff: () => setState(() => healthLoading = false),
                onDone: () {
                  FilePaths.health_last_Data_path = healthController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Health Saved ✅")),
                  );
                },
              );
            },
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// ALARM
          CustomChanges(
            controller: alarmController,
            title: "Alarm CSV",
            hint: "Path",
            is_saved: alarmLoading,
            ontap_prefix_icon: () async {
              final path = await pickFile("csv");
              if (path != null) {
                setState(() => alarmController.text = path);
              }
            },
            save_operation: () async {
              await saveFile(
                key: "alarm",
                path: alarmController.text,
                setLoadingOn: () => setState(() => alarmLoading = true),
                setLoadingOff: () => setState(() => alarmLoading = false),
                onDone: () {
                  FilePaths.alarm_last_Data_path = alarmController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Alarm Saved ✅")),
                  );
                },
              );
            },
          ),

          CustomDivider(),

          //////////////////////////////////////////////////
          /// PASSWORD
          CustomChanges(
            controller: passwordController,
            prefix_icon: Icons.password,
            title: "Password",
            hint: "New password",
            is_saved: passLoading,
            ontap_prefix_icon: () {},
            save_operation: () async {
              setState(() => passLoading = true);
              await updatePassword(passwordController.text);
              setState(() => passLoading = false);
            },
          ),

          CustomDivider(),
        ],
      ),
    );
  }
}
