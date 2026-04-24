import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spu_linux_app/DataBase/Analysis_data.dart';
import 'package:spu_linux_app/widgets/custom_liner_charts.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  PointAnalysisModel? point;
  LabelAnalysisModel? label;
  AnalysisSpacing? spacing;
  Timer? timer;
  Future<void> loadData() async {
    final pointData = await loadPointAnalysisFromFile();
    final labelData = await loadLabelAnalysisFromFile();
    final spacingData = await loadAnalysisSpacingFromFile();

    if (!mounted) return;

    setState(() {
      point = pointData;
      label = labelData;
      spacing = spacingData;
    });
  }

double getMinX(List points) {
    if (points.isEmpty) return 0;

    return points
        .map((e) => double.parse(e.toString()))
        .reduce((a, b) => a < b ? a : b);
  }

double getMaxX(List points) {
    if (points.isEmpty) return 10;

    return points
        .map((e) => double.parse(e.toString()))
        .reduce((a, b) => a > b ? a : b);
  }
double getMinY(List points) {
    if (points.isEmpty) return 0;

    return points
        .map((e) => double.parse(e.toString()))
        .reduce((a, b) => a < b ? a : b);
  }

double getMaxY(List points) {
    if (points.isEmpty) return 10;

    return points
        .map((e) => double.parse(e.toString()))
        .reduce((a, b) => a > b ? a : b);
  }

  @override
  void initState() {
    super.initState();
    // load data
    Timer.periodic(const Duration(milliseconds: 100), (_) async {
      await loadData();
      if (!mounted) return;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomLineChart(
        minX: getMinX(label?.xPoints ?? []),
        maxX: getMaxX(label?.xPoints ?? []),
        minY: getMinY(label?.xPoints ?? []),
        maxY: getMaxY(label?.xPoints ?? []),

        spacing: (spacing?.Spacing ?? 1) <= 0 ? 1 : spacing?.Spacing??1,

        xLabels: label?.xPoints.map((e) => e.toString()).toList() ?? [],
        yLabels: label?.yPoints.map((e) => e.toString()).toList() ?? [],

        spots: getSpots(point ?? PointAnalysisModel(xPoints: [], yPoints: [])),

        padding_int_h: 30,
      ),
    );
  }
}
