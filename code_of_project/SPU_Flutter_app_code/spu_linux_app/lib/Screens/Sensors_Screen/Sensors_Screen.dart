// ignore_for_file: non_constant_identifier_names, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spu_linux_app/Screens/Sensors_Screen/widgets/set_time_analysis_widget.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  State<SensorsScreen> createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  //---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [Gap(30), SetTimeAnalysisWidget(), Gap(30)]),
      ),
    );
  }
}
