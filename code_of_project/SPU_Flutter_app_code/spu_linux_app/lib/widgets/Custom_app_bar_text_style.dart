import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomAppBarTextStyle {
  // ignore: non_constant_identifier_names
  static TextStyle appbar_text_style({double size = 30}) {
    return TextStyle(
      color: AppColors.home_screen_title_alarm_color,
      fontWeight: FontWeight.bold,
      fontSize: size,
    );
  }
}
