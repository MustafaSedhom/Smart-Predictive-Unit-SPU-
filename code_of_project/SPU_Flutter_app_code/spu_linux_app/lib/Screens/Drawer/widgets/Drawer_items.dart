import 'package:flutter/cupertino.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final Widget page;

  DrawerItem({required this.title, required this.icon, required this.page});
}
