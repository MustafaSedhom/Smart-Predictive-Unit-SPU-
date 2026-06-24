import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/widgets/settings_global.dart';

class SpuLogoSetting extends StatefulWidget {
  const SpuLogoSetting({super.key});

  @override
  State<SpuLogoSetting> createState() => _SpuLogoSettingState();
}

class _SpuLogoSettingState extends State<SpuLogoSetting> {
  File? image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString("SPU_Logo_image_path");

    if (path != null) {
      final file = File(path);
      if (mounted) {
        setState(() {
          image = file;
        });
      }
      if (file.existsSync()) {
        logoNotifier.value = file;
      }
    }
  }

  Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final path = pickedFile.path;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("SPU_Logo_image_path", path);

      final file = File(path);
      if (mounted) {
        setState(() {
          image = file;
        });
      }
      logoNotifier.value = file;
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: image != null ? Colors.white10 : Colors.white12,
                      width: 1,
                    ),
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: image != null
                      ? Image.file(image!, fit: BoxFit.contain)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fingerprint_rounded,
                              color: Colors.white.withOpacity(0.25),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Map transparent insignia",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.25),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
                      Icons.refresh_rounded,
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
