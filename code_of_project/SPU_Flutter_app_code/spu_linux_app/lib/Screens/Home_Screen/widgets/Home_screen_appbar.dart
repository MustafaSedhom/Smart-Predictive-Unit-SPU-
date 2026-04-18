import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Home_Screen/widgets/Home_screen_time_and_date.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            // 1. Titles
            Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "SMART PREDICTIVE UNIT (SPU)",
                  style: TextStyle(
                    fontSize: 12,
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
            Gap(screenWidth * 0.15),
            DigitalClockWidget(),
            const Gap(15),
            Row(
              children: const [
                Icon(Icons.account_circle, size: 35, color: Colors.white),
                Gap(8),
                Text(
                  "Admin",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),

            const Gap(10),
            _buildStatusIndicator(),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // ignore: deprecated_member_use
        color: AppColors.Start_indicator_background_color.withOpacity(0.7),
        border: Border.all(
          // ignore: deprecated_member_use
          color: AppColors.Start_indicator_color.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.lightGreen,
              shape: BoxShape.circle,
            ),
          ),
          const Gap(10),
          const Text(
            "System Running",
            style: TextStyle(
              color: Colors.lightGreen,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
