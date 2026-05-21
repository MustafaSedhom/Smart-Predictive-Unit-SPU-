import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_time_and_date.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenAppbar extends StatefulWidget {
  const HomeScreenAppbar({super.key});

  @override
  State<HomeScreenAppbar> createState() => _HomeScreenAppbarState();
}

File? image;

class _HomeScreenAppbarState extends State<HomeScreenAppbar> {
  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString("HomeScreen_image_path");

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
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            // 1. Titles
            Gap(25),

            Text(
              "SMART PREDICTIVE UNIT (SPU)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.Drawer_logo_text_color,
              ),
            ),

            Gap(screenWidth * 0.2),
            DigitalClockWidget(),
            Gap(10),
            CircleAvatar(
              // radius: 30,
              backgroundImage: image != null
                  ? FileImage(image!, scale: 1)
                  : null,
            ),

            const Gap(10),
            _buildStatusIndicator(),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        color: AppColors.Start_indicator_background_color.withOpacity(0.7),
        border: Border.all(
          // ignore: deprecated_member_use
          color: AppColors.Start_indicator_color.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.lightGreen,
              shape: BoxShape.circle,
            ),
          ),
          const Gap(10),
          const Text(
            "System Running",
            style: TextStyle(
              color: Colors.lightGreen,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
