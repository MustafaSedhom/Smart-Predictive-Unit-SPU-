import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/widgets/Custom_changes.dart';
import 'package:spu_linux_app/widgets/Custom_app_bar_text_style.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class AdvancedSettingScreen extends StatefulWidget {
  const AdvancedSettingScreen({super.key});

  @override
  State<AdvancedSettingScreen> createState() => _AdvancedSettingScreenState();
}

class _AdvancedSettingScreenState extends State<AdvancedSettingScreen> {
  TextEditingController filePathController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FilePickerResult? result;
  // ignore: non_constant_identifier_names
  String? File_path = "";
  // ignore: non_constant_identifier_names
  bool file_load = false;
  // ignore: non_constant_identifier_names
  bool pass_change = false;
  Future<void> saveFilePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("file_path", path);
  }

  Future<void> loadSavedPath() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedPath = prefs.getString("file_path");

    if (savedPath != null) {
      setState(() {
        filePathController.text = savedPath;
      });
    }
  }

  Future<String?> getFilePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("file_path");
  }

  Future<String?> loadFilePath() async {
    result = await FilePicker.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["json"],
    );
    if (result != null) {
      PlatformFile file = result!.files.first;
      File_path = File_path;
      return file.path!;
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
    loadPath();
  }

  void loadPath() async {
    String? path = await getFilePath();
    if (path != null) {
      setState(() {
        filePathController.text = path;
        JsonFilePath.path = path;
      });
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> update_admin_password(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("password", password);
  }

  @override
  void dispose() {
    filePathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(10),
          // appbar
          Text(
            "Advanced Setting",
            style: CustomAppBarTextStyle.appbar_text_style(),
          ),
          // divider
          CustomDivider(),
          // file path setting
          CustomChanges(
            controller: filePathController,
            title: "Data Base File :",
            hint: "File Path",
            is_saved: file_load,
            ontap_prefix_icon: () async {
              String? path = await loadFilePath();

              if (path != null) {
                setState(() {
                  filePathController.text = path;
                });
              }
            },
            save_operation: file_load
                ? () {}
                : () async {
                    setState(() => file_load = true);

                    try {
                      if (filePathController.text.isNotEmpty) {
                        await saveFilePath(filePathController.text);
                        JsonFilePath.path = filePathController.text;
                      }

                      await Future.delayed(Duration(milliseconds: 500));

                      if (!mounted) return;

                      ScaffoldMessenger.of(
                        // ignore: use_build_context_synchronously
                        context,
                      ).showSnackBar(
                        SnackBar(content: Text("file path Saved ✅")),
                      );
                    } finally {
                      if (mounted) {
                        setState(() => file_load = false);
                      }
                    }
                  },
          ),
          // divider
          CustomDivider(),
          // change password setting
          CustomChanges(
            controller: passwordController,
            title: "New Password :",
            hint: "new password",
            prefix_icon: Icons.password_rounded,
            is_saved: pass_change,
            ontap_prefix_icon: () async {},
            save_operation: pass_change
                ? () {}
                : () async {
                    final password = passwordController.text.trim();

                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password cannot be empty❌")),
                      );
                      return;
                    }

                    setState(() => pass_change = true);

                    try {
                      await update_admin_password(password);

                      await Future.delayed(Duration(milliseconds: 500));

                      if (!mounted) return;

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password updated ✅")),
                      );
                    } finally {
                      if (mounted) {
                        setState(() => pass_change = false);
                      }
                    }
                  },
          ),
          // divider
          CustomDivider(),
        ],
      ),
    );
  }
}
