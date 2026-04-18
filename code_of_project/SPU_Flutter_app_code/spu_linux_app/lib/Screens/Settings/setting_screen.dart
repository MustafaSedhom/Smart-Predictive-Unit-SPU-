// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_Master_cards.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_appbar.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_titles.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screen_hight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Text(
            "SETTING",
            style: TextStyle(fontSize: 50, color: AppColors.Drawer_text_color),
          ),
        ],
      ),
    );
  }
}
