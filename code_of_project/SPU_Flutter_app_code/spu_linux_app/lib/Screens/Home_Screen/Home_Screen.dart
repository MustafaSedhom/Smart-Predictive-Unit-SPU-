import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Drawer_Widget.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_containe.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Home_screen_background,
      body: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerWidget(),

            const Expanded(child: HomeScreenContainers()),
          ],
        ),
      ),
    );
  }
}
