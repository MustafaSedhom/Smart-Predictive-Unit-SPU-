import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Divider(
        color: AppColors.Drawer_logo_text_color,
        thickness: 2,
        radius: BorderRadius.circular(10),
      ),
    );
  }
}
