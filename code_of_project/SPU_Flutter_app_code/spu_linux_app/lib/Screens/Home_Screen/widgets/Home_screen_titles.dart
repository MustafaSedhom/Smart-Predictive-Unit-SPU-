import 'package:flutter/material.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
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
          icon: Icons.health_and_safety_rounded,
          title_upper: "Overall Health",
          title_down: "${70}%",
          card_color: AppColors.Drawer_icon_selected_color,
          title_upper_color: AppColors.Drawer_icon_selected_color,
        ),
        HomeScreenTitleCard(
          icon: Icons.notifications,
          title_upper: "Active Alarms",
          title_down: "${3}",
          card_color: AppColors.Start_indicator_color,
          title_upper_color: AppColors.Start_indicator_color,
        ),
        HomeScreenTitleCard(
          icon: Icons.settings_input_antenna_sharp,
          title_upper: "Sensor Connected",
          title_down: "${15}/${16}",
          card_color: AppColors.Start_indicator_background_color,
        ),
        HomeScreenTitleCard(
          icon: Icons.calendar_month_rounded,
          title_upper: "Next Maintenance",
          title_down: "in ${18} Days",
          card_color: AppColors.Drawer_text_color,
        ),
      ],
    );
  }
}
