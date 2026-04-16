import 'package:flutter/material.dart';

class ScreenArea {
  static late double Width;
  static late double Height;

  static void init(BuildContext context) {
    Width = MediaQuery.of(context).size.width;
    Height = MediaQuery.of(context).size.height;
  }

  static bool isMobile() {
    return Width < 600;
  }

  static bool isTablet() {
    return Width >= 600 && Width < 1200;
  }

  static bool isDesktop() {
    return Width >= 1200;
  }
}
