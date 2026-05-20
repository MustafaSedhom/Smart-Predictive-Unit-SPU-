// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const Color Home_screen_background = Color(0xff081831);
  static const Color Drawer_color = Color(0xff020e24);
  static const Color Drawer_text_color = Color(0xffffffff);
  static const Color Drawer_logo_text_color = Color(0xff6bc2ef);
  static const Color Drawer_selected_color = Color(0xff053879);
  static const Color Drawer_icon_selected_color = Color(0xff7de8ff);
  static const Color Start_Button_color = Color(0xff05793a);
  static const Color Start_indicator_color = Color(0xff13daa1);
  static const Color Start_indicator_background_color = Color(0xff03533c);
  static const Color home_screen_title_health_color = Colors.blue;
  static const Color home_screen_title_alarm_color = Colors.amber;
  static const Color home_screen_title_sensor_color = Colors.green;
  static const Color home_screen_title_maintenance_color = Colors.deepPurple;
  static const Color button_master_card_1_color = Color(0xff0559c3);

  static const Color button_master_card_2_color = Color(0xff28374c);
  static const List<Color> color_list = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.purple,
    Colors.deepPurpleAccent,
    Colors.black,
    Colors.grey,
    Colors.blueGrey,
    Home_screen_background,
  ];
  static const List<BoxShadow> shadow_list = [
    BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
    BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
    BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(1, 1)),
  ];
}
