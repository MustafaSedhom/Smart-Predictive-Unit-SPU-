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
  Timer? timer;
  Future<void> loadData() async {
    final pointData = await loadPointAnalysisFromFile();
    final labelData = await loadLabelAnalysisFromFile();

    if (!mounted) return;

    setState(() {
      point = pointData;
      label = labelData;
    });
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
        xLabels: label?.xPoints ?? [],
        yLabels: label?.yPoints ?? [],
        spots: getSpots(point ?? PointAnalysisModel(xPoints: [], yPoints: [])),
        padding_int_h: 30,
      ),
    );
  }
}
