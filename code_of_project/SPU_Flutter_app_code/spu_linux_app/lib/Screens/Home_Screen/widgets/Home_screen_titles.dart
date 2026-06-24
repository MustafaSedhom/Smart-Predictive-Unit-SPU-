import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/DataBase/Global_Card_Data.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_title_card.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenTitles extends StatefulWidget {
  const HomeScreenTitles({super.key});

  @override
  State<HomeScreenTitles> createState() => _HomeScreenTitlesState();
}

class _HomeScreenTitlesState extends State<HomeScreenTitles> {
  SystemData? global;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final globalData = await loadSystemFromFile();

    if (!mounted) return;

    setState(() {
      global = globalData;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, non_constant_identifier_names
    double screen_width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      physics:
          const BouncingScrollPhysics(), // Adds a smooth feel on Linux/Windows
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HomeScreenTitleCard(
            icon_img: AppIcons.heart_rate_Icon,
            title_upper: "Overall Health",
            title_down: "${global?.overallHealth ?? 0}%",
            card_color: AppColors.home_screen_title_health_color,
          ),

          Gap(screen_width * 0.05),

          HomeScreenTitleCard(
            icon_img: AppIcons.bell_Icon,
            title_upper: "Active Alarms",
            title_down: "${global?.activeAlarms ?? "∞"}",
            card_color: Colors.red,
          ),

          Gap(screen_width * 0.05),

          HomeScreenTitleCard(
            icon_img: AppIcons.sensor_connected_Icon,
            title_upper: "Sensors Online",
            title_down:
                "${global?.sensorsOnline.active ?? "∞"} / ${global?.sensorsOnline.total ?? "∞"}",
            card_color: AppColors.home_screen_title_sensor_color,
          ),

          Gap(screen_width * 0.05),

          HomeScreenTitleCard(
            icon_img: AppIcons.calender_Icon,
            title_upper: "Next Maintenance",
            title_down: "${global?.nextMaintenance ?? 0} Days",
            card_color: AppColors.home_screen_title_maintenance_color,
          ),
        ],
      ),
    );
  }
}
