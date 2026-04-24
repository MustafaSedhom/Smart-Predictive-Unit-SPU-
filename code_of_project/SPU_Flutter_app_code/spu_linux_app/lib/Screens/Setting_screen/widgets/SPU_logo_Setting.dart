import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/settings_global.dart';

class SpuLogoSetting extends StatefulWidget {
  const SpuLogoSetting({super.key});

  @override
  State<SpuLogoSetting> createState() => _SpuLogoSettingState();
}

class _SpuLogoSettingState extends State<SpuLogoSetting> {
  File? image;

  Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final path = pickedFile.path;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("SPU_Logo_image_path", path);
      // ignore: unnecessary_null_comparison
      if (path != null) {
        setState(() {
          image = File(path);
        });
      }
      logoNotifier.value = File(path);
    }
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString("SPU_Logo_image_path");

    if (path != null) {
      setState(() {
        image = File(path);
      });
    }
    if (path != null && File(path).existsSync()) {
      logoNotifier.value = File(path);
    }
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: pickAndSaveImage,
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: image != null ? FileImage(image!) : null,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: AppColors.Home_screen_background,
                ),
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: AppColors.Drawer_text_color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: pickAndSaveImage,
                      child: Icon(Icons.edit, size: 40),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
