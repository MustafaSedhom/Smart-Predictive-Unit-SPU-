import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_custom_cards.dart';

class HomeScreenMasterCard extends StatelessWidget {
  const HomeScreenMasterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeScreenMasterCustomCards(
          card_color: Colors.green,
          value: 82,
          name: 'MOTOR',
          img: "assets/images/motor.png",
          img_icon: "assets/Icons/motor_icon.png",
          icon: Icons.macro_off,
          status_name: 'NORMAL',
        ),
        HomeScreenMasterCustomCards(
          card_color: Colors.amber,
          value: 64,
          name: 'BELT DRIVE',
          img: "assets/images/motor_belt.png",
          img_icon: "assets/Icons/motor_belt_icon.png",
          icon: Icons.macro_off,
          status_name: 'WARNING',
        ),
        HomeScreenMasterCustomCards(
          card_color: Colors.red,
          value: 38,
          name: 'PUMP',
          img: "assets/images/motor_pump.png",
          img_icon: "assets/Icons/motor_pump_icon.png",
          icon: Icons.macro_off,
          status_name: 'ALERT',
        ),
      ],
    );
  }
}
