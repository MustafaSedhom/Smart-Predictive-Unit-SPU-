import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_custom_cards.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenMasterCard extends StatelessWidget {
  const HomeScreenMasterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeScreenMasterCustomCards(
          card_color: AppColors.home_screen_title_sensor_color,
        ),
        HomeScreenMasterCustomCards(
          card_color: AppColors.home_screen_title_health_color,
        ),
        HomeScreenMasterCustomCards(
          card_color: AppColors.home_screen_title_alarm_color,
        ),
      ],
    );
  }
}
