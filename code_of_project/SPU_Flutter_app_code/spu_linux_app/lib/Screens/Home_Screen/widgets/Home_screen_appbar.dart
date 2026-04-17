import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Responsive/Screen_Area.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_time_and_date.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "SMART PREDICTIVE UNIT (SPU)",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "Condition Monitoring & Predictive Maintenance",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),

          const Spacer(),
          const Gap(30),
          DigitalClockWidget(),

          const Gap(30),

          Row(
            children: const [
              Icon(Icons.account_circle, size: 35, color: Colors.white),
              Gap(8),
              Text(
                "Admin",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const Gap(30),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.Start_indicator_background_color.withOpacity(
                0.2,
              ),
              border: Border.all(
                color: AppColors.Start_indicator_color.withOpacity(0.5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.Start_indicator_color,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Text(
                  "System Running",
                  style: TextStyle(
                    color: AppColors.Start_indicator_color,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
