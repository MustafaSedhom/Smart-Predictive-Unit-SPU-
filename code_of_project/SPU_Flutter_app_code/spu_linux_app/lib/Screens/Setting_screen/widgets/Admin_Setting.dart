import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminSetting extends StatefulWidget {
  const AdminSetting({super.key});

  @override
  State<AdminSetting> createState() => _AdminSettingState();
}

class _AdminSettingState extends State<AdminSetting> {
  File? image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString("HomeScreen_image_path");

    if (path != null && mounted) {
      setState(() {
        image = File(path);
      });
    }
  }

  Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final path = pickedFile.path;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("HomeScreen_image_path", path);

      if (mounted) {
        setState(() {
          image = File(path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: pickAndSaveImage,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: image != null
                          ? Colors.transparent
                          : Colors.white12,
                      width: 1,
                    ),
                    image: image != null
                        ? DecorationImage(
                            image: FileImage(image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.white.withOpacity(0.25),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Click to map media asset",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.25),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
              ),
            ),
          ),
          if (image != null)
            Positioned(
              right: 10,
              bottom: 10,
              child: Material(
                color: const Color(0xFF0F111A).withOpacity(0.85),
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: pickAndSaveImage,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF00F5D4).withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Color(0xFF00F5D4),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
