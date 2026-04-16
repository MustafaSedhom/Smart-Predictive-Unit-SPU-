import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class SpuLogoInDrawer extends StatelessWidget {
  const SpuLogoInDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "SPU",
      style: TextStyle(color: AppColors.Drawer_logo_text_color, fontSize: 24),
    );
  }
}
