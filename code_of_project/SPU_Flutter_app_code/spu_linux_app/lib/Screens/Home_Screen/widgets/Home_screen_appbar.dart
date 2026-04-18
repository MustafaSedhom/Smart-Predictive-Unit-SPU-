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
      height: 100,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            // 1. Titles
            Gap(30),
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
            Gap(screenWidth * 0.36),
            DigitalClockWidget(),
            const Gap(30),
            Row(
              children: const [
                Icon(Icons.account_circle, size: 35, color: Colors.white),
                Gap(8),
                Text(
                  "Admin",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),

            const Gap(30),
            _buildStatusIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.Start_indicator_background_color.withOpacity(0.1),
        border: Border.all(
          color: AppColors.Start_indicator_color.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const Gap(10),
          const Text(
            "System Running",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
