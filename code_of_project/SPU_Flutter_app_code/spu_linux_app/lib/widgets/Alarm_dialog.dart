import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spu_linux_app/Images/images_and_icons.dart';
import 'package:spu_linux_app/colors/App_colors.dart';

Future<void> showAlarmDialog(
  BuildContext context, {
  String message = "Massage",
  // ignore: non_constant_identifier_names
  int close_time_seconds = 2,
  // ignore: non_constant_identifier_names
  bool auto_close = false,
  String img = AppIcons.motor_Icon,
  // ignore: non_constant_identifier_names
  Color alarm_color = Colors.red,
  // ignore: non_constant_identifier_names
  Color box_color = Colors.black87,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      // ✅ safe auto close
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
        offset: Offset(0, 0),
        sigma: 30,
        child: AlertDialog(
          // ignore: deprecated_member_use
          backgroundColor: box_color.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
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
              Gap(10),
              // massage
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
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
                  // ignore: deprecated_member_use
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
