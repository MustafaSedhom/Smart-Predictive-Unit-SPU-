import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_title_card.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenTitles extends StatelessWidget {
  const HomeScreenTitles({super.key});

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
            icon_img: "assets/Icons/heart-rate.png",
            title_upper: "Overall Health",
            title_down: "70%",
            card_color: AppColors.home_screen_title_health_color,
          ),

          Gap(screen_width * 0.05),

          HomeScreenTitleCard(
            icon_img: "assets/Icons/bell.png",
            title_upper: "Active Alarms",
            title_down: "3",
            card_color: AppColors.home_screen_title_alarm_color,
          ),

          Gap(screen_width * 0.05),

          HomeScreenTitleCard(
            icon_img: "assets/Icons/smart-grid.png",
            title_upper: "Sensors Online",
            title_down: "15/16",
            card_color: AppColors.home_screen_title_sensor_color,
          ),

          Gap(screen_width * 0.05),

          HomeScreenTitleCard(
            icon_img: "assets/Icons/calendar.png",
            title_upper: "Next Maintenance",
            title_down: "18 Days",
            card_color: AppColors.home_screen_title_maintenance_color,
          ),
        ],
      ),
    );
  }
}
