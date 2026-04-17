import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_title_card.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenTitles extends StatelessWidget {
  const HomeScreenTitles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HomeScreenTitleCard(
          icon_img: "assets/Icons/heart-rate.png",
          title_upper: "Overall Health",
          title_down: "${70}%",
          card_color: AppColors.home_screen_title_health_color,
        ),
        HomeScreenTitleCard(
          icon_img: "assets/Icons/bell.png",
          title_upper: "Active Alarms",
          title_down: "${3}",
          card_color: AppColors.home_screen_title_alarm_color,
        ),
        HomeScreenTitleCard(
          icon_img: "assets/Icons/smart-grid.png",
          title_upper: "Sensor Connected",
          title_down: "${15}/${16}",
          card_color: AppColors.home_screen_title_sensor_color,
        ),
        HomeScreenTitleCard(
          icon_img: "assets/Icons/calendar.png",
          title_upper: "Next Maintenance",
          title_down: "in ${18} Days",
          card_color: AppColors.home_screen_title_maintenance_color,
        ),
      ],
    );
  }
}
