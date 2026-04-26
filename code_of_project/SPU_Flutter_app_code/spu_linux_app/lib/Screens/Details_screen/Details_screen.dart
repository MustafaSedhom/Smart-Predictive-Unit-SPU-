// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/Motor_details.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/belt_Driver_details.dart';
import 'package:spu_linux_app/Screens/Details_screen/widgets/pump_details.dart';
import 'package:spu_linux_app/colors/App_colors.dart';
import 'package:spu_linux_app/widgets/Custom_divider.dart';
import 'package:spu_linux_app/widgets/settings_global.dart';

class DetailsScreen extends StatefulWidget {
  final Actuator? goto;

  const DetailsScreen({super.key, this.goto = Actuator.Motor});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final ScrollController _controller = ScrollController();

  final GlobalKey motorKey = GlobalKey();
  final GlobalKey beltKey = GlobalKey();
  final GlobalKey pumpKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollTo();
    });
  }

  void scrollTo() {
    GlobalKey selectedKey;

    if (widget.goto == Actuator.Motor) {
      selectedKey = motorKey;
    } else if (widget.goto == Actuator.Belt) {
      selectedKey = beltKey;
    } else {
      selectedKey = pumpKey;
    }

    final context = selectedKey.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),

        Text(
          "Actuators Details",
          style: TextStyle(
            color: AppColors.home_screen_title_alarm_color,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const Gap(10),
        const CustomDivider(),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: ListView(
              controller: _controller,
              children: [
                Container(key: motorKey, child: const MotorDetails()),

                const Gap(20),

                Container(key: beltKey, child: const BeltDriverDetails()),

                const Gap(20),

                Container(key: pumpKey, child: const PumpDetails()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
