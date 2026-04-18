import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Drawer/Drawer_Widget.dart';
import 'package:spu_linux_app/Screens/Drawer/widgets/Drawer_items.dart';
import 'package:spu_linux_app/Screens/Home_Screen/Home_Screen.dart';
import 'package:spu_linux_app/Screens/Setting_screen/setting_screen.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

// ignore: must_be_immutable
class DrawAllScreens extends StatefulWidget {
  const DrawAllScreens({super.key});

  @override
  State<DrawAllScreens> createState() => _DrawAllScreensState();
}

class _DrawAllScreensState extends State<DrawAllScreens> {
  int selectedIndex = 0;

  List<DrawerItem> menuItems = [
    DrawerItem(
      title: "Home",
      icon: Icons.home_rounded,
      page: const HomeScreen(),
    ),
    DrawerItem(title: "Message", icon: Icons.message, page: const HomeScreen()),
    DrawerItem(
      title: "Alarm",
      icon: Icons.notifications,
      page: const HomeScreen(),
    ),
    DrawerItem(title: "Profile", icon: Icons.person, page: const HomeScreen()),
    DrawerItem(
      title: "Settings",
      icon: Icons.settings,
      page: const SettingScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Home_screen_background,
      body: SizedBox.expand(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerWidget(
              data: menuItems,
              ontap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedIndex: selectedIndex,
            ),
            // Expanded(
            //   child: IndexedStack(
            //     index: selectedIndex,
            //     children: menuItems.map((item) => item.page).toList(),
            //   ),
            // ),
            Expanded(child: menuItems[selectedIndex].page),
          ],
        ),
      ),
    );
  }
}
