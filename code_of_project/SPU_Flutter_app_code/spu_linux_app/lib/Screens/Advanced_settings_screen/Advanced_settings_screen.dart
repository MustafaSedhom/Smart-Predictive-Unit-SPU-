import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';
import 'package:spu_linux_app/Screens/Setting_screen/widgets/Custom_text_feild.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class AdvancedSettingScreen extends StatefulWidget {
  const AdvancedSettingScreen({super.key});

  @override
  State<AdvancedSettingScreen> createState() => _AdvancedSettingScreenState();
}

class _AdvancedSettingScreenState extends State<AdvancedSettingScreen> {
  TextEditingController nameController = TextEditingController();
  FilePickerResult? result;
  // ignore: non_constant_identifier_names
  String? File_path = "";
  bool isLoading = false;
  Future<void> saveFilePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("file_path", path);
  }

  Future<void> loadSavedPath() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedPath = prefs.getString("file_path");

    if (savedPath != null) {
      setState(() {
        nameController.text = savedPath;
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
        nameController.text = path;
        JsonFilePath.path = path;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(20),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // title
                  Text(
                    "File Data Base :",
                    style: TextStyle(
                      color: AppColors.Drawer_text_color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(20),
                  // Text field
                  Expanded(
                    child: CustomTextField(
                      controller: nameController,
                      hint: "Json File Path",
                      prefix_icon: Icons.upload_file,
                      ontap_prefix_icon: () async {
                        String? path = await loadFilePath();

                        if (path != null) {
                          setState(() {
                            nameController.text = path;
                          });
                        }
                      },
                    ),
                  ),
                  Gap(20),
                  // Save Button
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() => isLoading = true);

                            if (nameController.text.isNotEmpty) {
                              await saveFilePath(nameController.text);
                              JsonFilePath.path = nameController.text;
                            }

                            await Future.delayed(Duration(seconds: 1));

                            setState(() => isLoading = false);

                            ScaffoldMessenger.of(
                              // ignore: use_build_context_synchronously
                              context,
                            ).showSnackBar(SnackBar(content: Text("Saved ✅")));
                          },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.button_master_card_1_color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.Drawer_text_color,
                            ),
                          )
                        : Text(
                            "Save",
                            style: TextStyle(
                              color: AppColors.Drawer_text_color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
