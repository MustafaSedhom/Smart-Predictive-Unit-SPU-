import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    return Container(
      width: 400,
      color: AppColors.Drawer_color,
      child: ListView(
        children: [
          DrawerHeader(child: SpuLogoInDrawer()),
          DrawerElements(
            icon: Icons.home,
            text: "Home",
            isSelected: selectedIndex == 0,
            onTap: () {
              setState(() {
                onItemTapped(0);
              });
            },
          ),
          DrawerElements(
            icon: Icons.person,
            text: "Profile",
            isSelected: selectedIndex == 1,
            onTap: () {
              setState(() {
                onItemTapped(1);
              });
            },
          ),
          DrawerElements(
            icon: Icons.message,
            text: "Message",
            isSelected: selectedIndex == 2,
            onTap: () {
              onItemTapped(2);
            },
          ),
          DrawerElements(
            icon: Icons.alarm,
            text: "Alarm",
            isSelected: selectedIndex == 3,
            onTap: () {
              setState(() {
                onItemTapped(3);
              });
            },
          ),
          DrawerElements(
            icon: Icons.settings,
            text: "Settings",
            isSelected: selectedIndex == 4,
            onTap: () {
              setState(() {
                onItemTapped(4);
              });
            },
          ),
        ],
      ),
    );
  }
}
