import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(20),
          Text(
            "data",
            style: TextStyle(fontSize: 30, color: AppColors.Drawer_text_color),
          ),
        ],
      ),
    );
  }
}
