import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/settings_global.dart';

class SpuLogoInDrawer extends StatefulWidget {
  const SpuLogoInDrawer({super.key});

  @override
  State<SpuLogoInDrawer> createState() => _SpuLogoInDrawerState();
}

class _SpuLogoInDrawerState extends State<SpuLogoInDrawer> {
  File? image;
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
    // ignore: non_constant_identifier_names
    double screen_width = MediaQuery.of(context).size.width;
    // ignore: non_constant_identifier_names
    // double screen_hight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.Drawer_color,
        border: Border(
          top: BorderSide(color: AppColors.Drawer_text_color, width: 1),
          bottom: BorderSide(color: AppColors.Drawer_text_color, width: 1),
          left: BorderSide(color: AppColors.Drawer_text_color, width: 1),
          right: BorderSide(color: AppColors.Drawer_text_color, width: 1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ValueListenableBuilder<File?>(
        valueListenable: logoNotifier,
        builder: (context, image, _) {
          if (screen_width < 1000) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: image != null
                  ? CircleAvatar(
                      radius: screen_width * 0.05,
                      backgroundImage: FileImage(image),
                    )
                  : Icon(
                      Icons.image,
                      size: screen_width * 0.1,
                      color: Colors.grey,
                    ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Gap(2),
                image != null
                    ? CircleAvatar(
                        radius: screen_width * 0.03,
                        backgroundImage: FileImage(image),
                      )
                    : Icon(
                        Icons.image,
                        size: screen_width * 0.06,
                        color: Colors.grey,
                      ),
                Gap(screen_width * 0.01),
                Expanded(
                  child: Text(
                    "SPU",
                    style: GoogleFonts.poppins(
                      color: AppColors.Drawer_logo_text_color,
                      fontSize: screen_width * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
