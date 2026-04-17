import 'package:flutter/material.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:intl/intl.dart';

class DigitalClockWidget extends StatelessWidget {
  const DigitalClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        DateTime now = DateTime.now();
        String formattedTime = DateFormat('hh:mm:ss a').format(now);
        String formattedDate = DateFormat('dd/MM/yyyy').format(now);
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.Drawer_text_color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formattedTime,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.Drawer_text_color,
              ),
            ),
          ],
        );
      },
    );
  }
}
