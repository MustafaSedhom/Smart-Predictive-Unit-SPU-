import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Resbonsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Drawer_elements.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/SPU_logo_in_Drawer.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenArea.init(context);
    return Container(
      width: ScreenArea.Width * 0.2,
      color: AppColors.Drawer_color,
      child: Column(
        children: [
          DrawerHeader(child: SpuLogoInDrawer()),

          Expanded(
            child: ListView(
              children: [
                DrawerElements(
                  icon: Icons.home,
                  text: "Home",
                  isSelected: selectedIndex == 0,
                  onTap: () => onItemTapped(0),
                ),
                DrawerElements(
                  icon: Icons.person,
                  text: "Profile",
                  isSelected: selectedIndex == 1,
                  onTap: () => onItemTapped(1),
                ),
                DrawerElements(
                  icon: Icons.message,
                  text: "Message",
                  isSelected: selectedIndex == 2,
                  onTap: () => onItemTapped(2),
                ),
                DrawerElements(
                  icon: Icons.alarm,
                  text: "Alarm",
                  isSelected: selectedIndex == 3,
                  onTap: () => onItemTapped(3),
                ),
                DrawerElements(
                  icon: Icons.settings,
                  text: "Settings",
                  isSelected: selectedIndex == 4,
                  onTap: () => onItemTapped(4),
                ),
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.Start_Button_color,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                "START SYSTEM",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          Gap(5),
          TextButton(
            onPressed: () {},
            child: Text(
              "SPU  v1.0.0",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 30,
              ),
            ),
          ),
          Gap(30),
        ],
      ),
    );
  }
}
