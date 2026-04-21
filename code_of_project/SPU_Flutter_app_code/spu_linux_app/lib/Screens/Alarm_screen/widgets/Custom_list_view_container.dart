import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class CustomListViewContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const CustomListViewContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.Drawer_selected_color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 2)),
        ],
      ),
      child: Row(
        children: [
          // Icon(icon, size: 30, color: Colors.green),
          SimpleShadow(
            opacity: 0.9,
            color: AppColors.Drawer_logo_text_color,
            offset: Offset(2, 2),
            sigma: 10,
            child: Image.asset(
              "assets/icons/motor_icon.png",
              width: 50,
              height: 50,
              color: AppColors.Drawer_logo_text_color,
            ),
          ),
          Gap(15),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(5),
                Text(
                  value,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          /// STATUS ICON
          // Icon(Icons.circle, color: Colors.green, size: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "22/02/2006",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(5),
              Text(
                "06:18:23",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
