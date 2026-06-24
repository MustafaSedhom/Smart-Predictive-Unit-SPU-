// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/widgets/Custom_app_bar_text_style.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';

class AppBarSensorScreen extends StatelessWidget {
  const AppBarSensorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F38), Color(0xFF0F111A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text(
                'SENSOR ANALYSIS SETTINGS',
                style: CustomAppBarTextStyle.appbar_text_style(),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomDivider(),
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }
}
