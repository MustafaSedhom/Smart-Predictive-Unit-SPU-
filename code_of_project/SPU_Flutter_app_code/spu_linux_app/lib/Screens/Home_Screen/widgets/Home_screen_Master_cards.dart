import 'package:flutter/material.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_custom_cards.dart';

class HomeScreenMasterCard extends StatelessWidget {
  const HomeScreenMasterCard({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenArea.init(context);
    return Row(
      // scrollDirection: Axis.horizontal,
      // padding: EdgeInsets.zero,
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
          txt_1_up: 'Temprtautre',
          txt_1_down: '65 \u00B0C',
          txt_2_up: 'Vibration',
          txt_2_down: '3.3 mm/s',
          txt_3_up: 'Current',
          txt_3_down: '8.5 A',
          Days: 45,
          view_details: () {},
          configure: () {},
        ),
        HomeScreenMasterCustomCards(
          card_color: Colors.amber,
          value: 64,
          name: 'BELT DRIVE',
          img: "assets/images/motor_belt.png",
          img_icon: "assets/Icons/motor_belt_icon.png",
          icon: Icons.macro_off,
          status_name: 'WARNING',
          txt_1_up: 'Tension',
          txt_1_down: '385 N',
          txt_2_up: 'Alignment',
          txt_2_down: '0.5 mm',
          txt_3_up: 'Speed',
          txt_3_down: '1480 RPM',
          Days: 12,
          view_details: () {},
          configure: () {},
        ),
        HomeScreenMasterCustomCards(
          card_color: Colors.red,
          value: 38,
          name: 'PUMP',
          img: "assets/images/motor_pump.png",
          img_icon: "assets/Icons/motor_pump_icon.png",
          icon: Icons.macro_off,
          status_name: 'ALERT',
          txt_1_up: 'Pressure In',
          txt_1_down: '2.1 bar',
          txt_2_up: 'Flow Rate',
          txt_2_down: '18.5 L/min',
          txt_3_up: 'Temperature',
          txt_3_down: '72 \u00B0C',
          Days: 5,
          view_details: () {},
          configure: () {},
        ),
      ],
    );
  }
}
