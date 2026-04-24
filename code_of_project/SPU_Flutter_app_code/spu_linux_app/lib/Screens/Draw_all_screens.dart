import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/Advanced_settings_screen.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/widgets/Password_dialog.dart';
import 'package:spu_linux_app/Screens/Alarm_screen/Alarm_Screen.dart';
import 'package:spu_linux_app/Screens/Analysis_Screen/Analysis_screen.dart';
import 'package:spu_linux_app/Screens/Details_screen/Details_screen.dart';
import 'package:spu_linux_app/Screens/Home_Screen/Home_Screen.dart';
import 'package:spu_linux_app/Screens/Setting_screen/setting_screen.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Drawer/Drawer_Widget.dart';
import 'package:spu_linux_app/widgets/Drawer/widgets/Drawer_items.dart';

// ignore: must_be_immutable
class DrawAllScreens extends StatefulWidget {
  const DrawAllScreens({super.key});

  @override
  State<DrawAllScreens> createState() => _DrawAllScreensState();
}

class _DrawAllScreensState extends State<DrawAllScreens> {
  int selectedIndex = 0;
  Future<void> openAdvancedSetting(int index) async {
    if (menuItems[index].title == "Advanced") {
      bool result = await showPasswordDialog(context);

      if (!result) return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  List<DrawerItem> get menuItems => [
    DrawerItem(title: "Home", icon: Icons.home_rounded, page: HomeScreen()),
    DrawerItem(
      title: "Details",
      icon: Icons.data_saver_off_rounded,
      page: DetailsScreen(),
    ),
    DrawerItem(title: "Alarm", icon: Icons.notifications, page: AlarmScreen()),
    DrawerItem(
      title: "Analysis",
      icon: Icons.analytics,
      page: AnalysisScreen(),
    ),
    DrawerItem(
      title: "Settings",
      icon: Icons.settings,
      page: SettingScreen(
        advanced_setting_ontap: () async {
          bool result = await showPasswordDialog(context);

          if (result) {
            setState(() {
              selectedIndex = 5; // Advanced index
            });
          }
        }, 
      ),
    ),

    DrawerItem(
      title: "Advanced",
      icon: Icons.settings_suggest,
      page: AdvancedSettingScreen(),
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
              ontap: (index) async {
                if (menuItems[index].title == "Advanced") {
                  bool result = await showPasswordDialog(context);

                  if (result) {
                    setState(() {
                      selectedIndex = index;
                    });
                  }
                } else {
                  setState(() {
                    selectedIndex = index;
                  });
                }
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
