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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Map<String, IconData> drawerItems = {
      "Home": Icons.home_rounded,
      "Message": Icons.message,
      "Alarm": Icons.notifications,
      "Profile": Icons.person,
      "Settings": Icons.settings,
    };
    final items = drawerItems.entries.toList();

    return Container(
      width: screenWidth * 0.17,
      height: screenHeight,
      color: AppColors.Drawer_color,
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.15, child: SpuLogoInDrawer()),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.Start_Button_color,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      "START SYSTEM",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Text(
                  "SPU v1.0.0",
                  style: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
