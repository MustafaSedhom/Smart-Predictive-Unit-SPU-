import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({super.key});

  @override
  State<AdminSetting> createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  File? image;

  Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final path = pickedFile.path;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("image_path", path);

      setState(() {
        image = File(path);
      });
    }
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString("image_path");

    if (path != null) {
      setState(() {
        image = File(path);
      });
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
          ],
        ),
      ],
    );
  }
}
