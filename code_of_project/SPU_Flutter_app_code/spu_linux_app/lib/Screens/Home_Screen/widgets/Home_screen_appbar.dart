import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Gap(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            Text(
              "SMART REDUCTIVE UNIT (SPU)",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Condition Monitoring & Predictive Maintenance",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
        Spacer(),
        Column(
          children: [
            Gap(20),
            Text(
              "12/09/2023",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "10:30:43 AM",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Gap(20),
        Column(
          children: [
            Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(10),
                Icon(Icons.account_circle, size: 40, color: Colors.white),
                Gap(10),
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(20),
        Column(
          children: [
            Gap(20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // ignore: deprecated_member_use
                color: AppColors.Start_indicator_background_color.withOpacity(
                  0.8,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "System Running",
                  style: TextStyle(
                    color: AppColors.Start_indicator_color,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(20),
      ],
    );
  }
}
