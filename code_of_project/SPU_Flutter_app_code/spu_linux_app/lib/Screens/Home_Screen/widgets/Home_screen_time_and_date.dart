// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

class DigitalClockWidget extends StatelessWidget {
  const DigitalClockWidget({super.key});

  String getDayName(DateTime now) {
    return DateFormat('EEE').format(now).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        DateTime now = DateTime.now();

        String formattedTime = DateFormat('hh : mm : ss a').format(now);

        String formattedDate = DateFormat('dd / MM / yyyy').format(now);

        String dayName = getDayName(now);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),

            gradient: LinearGradient(
              colors: [const Color(0xff1E293B), const Color(0xff0F172A)],
            ),

            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// DAY
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

                decoration: BoxDecoration(
                  color: const Color(0xff22C55E).withOpacity(0.15),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: Text(
                  dayName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff22C55E),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              Gap(5),

              /// TIME + DATE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.Drawer_text_color,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const Gap(4),

                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
