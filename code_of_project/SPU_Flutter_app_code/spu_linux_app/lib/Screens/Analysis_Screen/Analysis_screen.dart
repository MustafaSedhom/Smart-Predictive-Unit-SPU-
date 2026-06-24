// ignore_for_file: deprecated_member_use

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
  bool isLoading = true;

  Future<void> loadData() async {
    final pointData = await loadPointAnalysisFromFile();
    final labelData = await loadLabelAnalysisFromFile();
    final spacingData = await loadAnalysisSpacingFromFile();

    if (!mounted) return;

    setState(() {
      point = pointData;
      label = labelData;
      spacing = spacingData;
      isLoading = false;
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
    timer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      await loadData();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),
      appBar: PreferredSize(
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
          child: AppBar(
            title: const Text(
              'PERFORMANCE METRICS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF00F5D4)),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF16192B),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xFF00F5D4).withOpacity(0.2),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00F5D4).withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Analytics Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Real-time data visualization",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  "ANALYSIS",
                                  style: TextStyle(
                                    color: Color(0xFF00F5D4),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 300,
                              
                                  child: CustomLineChart(
                                    minX: getMinX(label?.yPoints ?? []),
                                    maxX: getMaxX(label?.yPoints ?? []),
                                    minY: getMinY(label?.xPoints ?? []),
                                    maxY: getMaxY(label?.xPoints ?? []),
                                    spacing: (spacing?.Spacing ?? 1) <= 0
                                        ? 1
                                        : spacing?.Spacing ?? 1,
                                    xLabels:
                                        label?.yPoints
                                            .map((e) => e.toString())
                                            .toList() ??
                                        [],
                                    yLabels:
                                        label?.xPoints
                                            .map((e) => e.toString())
                                            .toList() ??
                                        [],
                                    spots: getSpots(
                                      point ??
                                          PointAnalysisModel(
                                            xPoints: [],
                                            yPoints: [],
                                          ),
                                    ),
                                    padding_int_h: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0, left: 24),
                            child: Center(
                              child: Text(
                                "DAYS",
                                style: TextStyle(
                                  color: Color(0xFF00F5D4),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
