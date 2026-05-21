// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

Future<void> showAlarmDialog(
  BuildContext context, {
  String message = "Message",
  String status = "normal",
  int close_time_seconds = 2,
  bool auto_close = false,
  String img = AppIcons.motor_Icon,
  Color alarm_color = Colors.red,
  Color box_color = Colors.black87,
}) {
  if (status.toUpperCase() == "NONE") {
    return Future.value();
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      /// ✅ AUTO CLOSE HERE
      if (auto_close) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(seconds: close_time_seconds), () {
            if (dialogContext.mounted) {
              Navigator.of(dialogContext, rootNavigator: true).pop();
            }
          });
        });
      }

      return SimpleShadow(
        opacity: 0.9,
        color: alarm_color,
        offset: const Offset(0, 0),
        sigma: 30,
        child: AlertDialog(
          backgroundColor: box_color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: alarm_color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: alarm_color, width: 2),
                ),
                child: Image.asset(
                  img,
                  color: alarm_color,
                  width: 30,
                  height: 30,
                ),
              ),

              const Gap(10),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: alarm_color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: alarm_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                "Close",
                style: TextStyle(
                  color: AppColors.Drawer_text_color.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
