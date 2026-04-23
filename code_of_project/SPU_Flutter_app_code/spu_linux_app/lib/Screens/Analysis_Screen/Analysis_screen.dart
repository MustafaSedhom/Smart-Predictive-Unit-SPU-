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
  AnalysisModel? analysis;
  Timer? timer;
  Future<void> loadData() async {
    final motorData = await loadAnalysisFromFile();

    if (!mounted) return;

    setState(() {
      analysis = motorData;
    });
  }

  @override
  void initState() {
    super.initState();
    // load data
    Timer.periodic(const Duration(milliseconds: 500), (_) async {
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
    return CustomLineChart(
      spots: getSpots(analysis ?? AnalysisModel(xPoints: [], yPoints: [])),
    );
  }
}
