import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  const CustomDivider({
    super.key,
    this.color = AppColors.Drawer_logo_text_color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Divider(
        color: color,
        thickness: 2,
        radius: BorderRadius.circular(10),
      ),
    );
  }
}
