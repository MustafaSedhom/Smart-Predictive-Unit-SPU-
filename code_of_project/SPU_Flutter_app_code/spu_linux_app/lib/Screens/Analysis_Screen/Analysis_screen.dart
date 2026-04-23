import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:spu_linux_app/widgets/custom_liner_charts.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomLineChart(
      spots: [
        FlSpot(0, 2),
        FlSpot(1, 5),
        FlSpot(2, 3),
        FlSpot(3, 8),
        FlSpot(4, 2),
        FlSpot(5, 5),
        FlSpot(6, 3),
        FlSpot(7, 8),
      ],
    );
  }
}
