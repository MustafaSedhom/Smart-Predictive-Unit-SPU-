import 'package:flutter/material.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/SPU_logo_in_Drawer.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: AppColors.Drawer_color,
      child: ListView(
        children: [
          DrawerHeader(child: SpuLogoInDrawer()),
          ListTile(
            title: Text(
              "Home",
              style: TextStyle(color: AppColors.Drawer_text_color),
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Settings",
              style: TextStyle(color: AppColors.Drawer_text_color),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
