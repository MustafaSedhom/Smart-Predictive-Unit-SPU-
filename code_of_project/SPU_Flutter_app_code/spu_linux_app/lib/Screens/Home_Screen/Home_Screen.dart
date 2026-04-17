import 'package:flutter/material.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Drawer_Widget.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_containe.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

/// Flutter code sample for [Drawer].
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ScreenArea.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Home_screen_background,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [DrawerWidget(), HomeScreenContainers()],
        ),
      ),
    );
  }
}
