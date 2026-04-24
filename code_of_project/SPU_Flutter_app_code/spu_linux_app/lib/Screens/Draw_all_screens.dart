// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spu_linux_app/Screens/Advanced_settings_screen/Advanced_settings_screen.dart';
import 'package:spu_linux_app/widgets/Password_dialog.dart';
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
  @override
  void initState() {
    super.initState();
    initPassword();
  }

  Future<void> initPassword() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("password")) {
      await prefs.setString("password", "2002");
    }
  }

  Future<void> openPage(int index) async {
    if (menuItems[index].title == "Advanced") {
      String? password = await loadPassword();

      bool result = await showPasswordDialog(context, password!);

      if (!result) return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  Future<String?> loadPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("password");
  }

  int selectedIndex = 0;
  Future<void> openAdvancedSetting(int index) async {
    if (menuItems[index].title == "Advanced") {
      String? savedPassword = await loadPassword();
      bool result = await showPasswordDialog(context, savedPassword ?? "2006");

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
          String? savedPassword = await loadPassword();

          bool result = await showPasswordDialog(
            context,
            savedPassword ?? "2006",
          );

          if (result) {
            setState(() {
              // ignore: recursive_getters
              selectedIndex = menuItems.indexWhere(
                (e) => e.title == "Advanced",
              );
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
  Future<void> savePassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("password", password);
  }

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
                openPage(index);
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
