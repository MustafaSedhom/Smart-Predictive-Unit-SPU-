// ignore_for_file: deprecated_member_use

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
      child: Row(
        children: [
          const Gap(25),

          Text(
            "SMART PREDICTIVE UNIT (SPU)",
            style: TextStyle(
              fontSize: screenWidth < 700 ? 14 : 18,
              fontWeight: FontWeight.bold,
              color: AppColors.Drawer_logo_text_color,
            ),
          ),

          const Spacer(),

          const DigitalClockWidget(),
          const Gap(10),

          CircleAvatar(
            radius: 18,
            backgroundImage: image != null ? FileImage(image!) : null,
            child: image == null ? const Icon(Icons.person) : null,
          ),

          const Gap(10),

          _buildStatusIndicator(),

          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.Start_indicator_background_color.withOpacity(0.7),
        border: Border.all(

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

Widget addCardButton(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(22),
    child: Container(
      width: 220,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xff2563EB), Color(0xff06B6D4)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white24,
            child: Icon(Icons.add, color: Colors.white, size: 28),
          ),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Card",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Create new machine",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
