import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/Alarm_Screen.dart';
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
  @override
  Widget build(BuildContext context) {
    List<DrawerItem> menuItems = [
      DrawerItem(title: "Home", icon: Icons.home_rounded, page: HomeScreen()),
      DrawerItem(
        title: "Details",
        icon: Icons.data_saver_off_rounded,
        page: HomeScreen(),
      ),
      DrawerItem(title: "Alarm", icon: Icons.notifications, page: AlarmScreen()),
      DrawerItem(title: "AI Data", icon: Icons.chat, page: HomeScreen()),
      DrawerItem(
        title: "Settings",
        icon: Icons.settings,
        page: SettingScreen(),
      ),
      DrawerItem(
        title: "About",
        icon: Icons.add_box_rounded,
        page: HomeScreen(),
      ),
    ];
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
