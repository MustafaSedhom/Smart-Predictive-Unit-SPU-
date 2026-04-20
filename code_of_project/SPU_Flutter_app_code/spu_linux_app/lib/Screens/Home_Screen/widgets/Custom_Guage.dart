import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomGuage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Color Guage_color;
  final int value;
  final Widget? center;
  const CustomGuage({
    super.key,
    // ignore: non_constant_identifier_names
    required this.Guage_color,
    required this.value,
    this.center,
  });

  @override
  State<CustomGuage> createState() => _CustomGuageState();
}

class _CustomGuageState extends State<CustomGuage> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 40,
      lineWidth: 10.0,
      percent: (widget.value <= 100) ? (widget.value / 100.0) : 1,
      circularStrokeCap: CircularStrokeCap.round,
      // ignore: deprecated_member_use
      backgroundColor: widget.Guage_color.withOpacity(0.3),
      progressColor: widget.Guage_color,
      startAngle: 0,
      animation: true,
      animationDuration: 1500,
      center: widget.center,
    );
  }
}
