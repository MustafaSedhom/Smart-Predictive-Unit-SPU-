import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenContainers extends StatelessWidget {
  const HomeScreenContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColors.Home_screen_background,
        child: Center(
          child: Text(
            "Main Content",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
