import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          top: BorderSide(color: AppColors.Drawer_text_color, width: 1),
          bottom: BorderSide(color: AppColors.Drawer_text_color, width: 1),
          left: BorderSide(color: AppColors.Drawer_text_color, width: 1),
          right: BorderSide(color: AppColors.Drawer_text_color, width: 1),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: (screen_width < 1000)
          ? Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image(
                image: AssetImage("assets/images/SPU_Logo.png"),
                width: screen_width * 0.1,
                height: screen_hight * 0.1,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Gap(2),
                Image(
                  image: AssetImage("assets/images/SPU_Logo.png"),
                  width: screen_width * 0.06,
                  height: screen_hight * 0.06,
                ),
                Gap(screen_width * 0.01),
                Expanded(
                  child: Text(
                    "SPU",
                    style: GoogleFonts.poppins(
                      color: AppColors.Drawer_logo_text_color,
                      fontSize: screen_width * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
