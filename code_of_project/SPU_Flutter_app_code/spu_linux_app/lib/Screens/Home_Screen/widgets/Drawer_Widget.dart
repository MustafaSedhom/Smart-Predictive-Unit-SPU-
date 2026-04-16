import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
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
    Map<String, dynamic> drawerItems = {
      "Home": Icons.home_rounded,
      "Message": Icons.message,
      "Alarm": Icons.notifications,
      "Profile": Icons.person,
      "Settings": Icons.settings,
    };
    ScreenArea.init(context);
    final items = drawerItems.entries.toList();
    return Container(
      width: ScreenArea.Width * 0.17,
      color: AppColors.Drawer_color,
      child: Column(
        children: [
          DrawerHeader(child: SpuLogoInDrawer()),

          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return DrawerElements(
                  icon: item.value,
                  text: item.key,
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),

          InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.Start_Button_color,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "START SYSTEM",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
          Gap(5),
          Text(
            "SPU  v1.0.0",
            style: TextStyle(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.5),
              fontSize: 30,
            ),
          ),
          Gap(30),
        ],
      ),
    );
  }
}
