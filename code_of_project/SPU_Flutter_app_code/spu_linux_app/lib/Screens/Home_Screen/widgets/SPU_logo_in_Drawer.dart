import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class SpuLogoInDrawer extends StatelessWidget {
  const SpuLogoInDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    double screen_width = MediaQuery.of(context).size.width;
    // ignore: non_constant_identifier_names
    double screen_hight = MediaQuery.of(context).size.height;
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
          Image(
            image: AssetImage("assets/images/SEDHOM.jpg"),
            width: screen_width * 0.05,
            height: screen_hight * 0.05,
          ),
          Text(
            "SPU",
            style: GoogleFonts.poppins(
              color: AppColors.Drawer_logo_text_color,
              fontSize: screen_width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
