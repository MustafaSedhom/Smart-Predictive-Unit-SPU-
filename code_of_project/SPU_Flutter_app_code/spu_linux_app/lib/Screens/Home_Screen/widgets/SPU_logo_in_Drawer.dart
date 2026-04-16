import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class SpuLogoInDrawer extends StatelessWidget {
  const SpuLogoInDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.Drawer_color,
        border: Border(
          top: BorderSide(color: AppColors.Drawer_text_color, width: 2),
          bottom: BorderSide(color: AppColors.Drawer_text_color, width: 2),
          left: BorderSide(color: AppColors.Drawer_text_color, width: 2),
          right: BorderSide(color: AppColors.Drawer_text_color, width: 2),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Icon(Icons.school, color: AppColors.Drawer_logo_text_color, size: 50),
          Image(
            image: AssetImage("assets/images/SEDHOM.jpg"),
            width: 60,
            height: 60,
          ),
          Text(
            "SPU",
            style: GoogleFonts.poppins(
              color: AppColors.Drawer_logo_text_color,
              fontSize: 70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
