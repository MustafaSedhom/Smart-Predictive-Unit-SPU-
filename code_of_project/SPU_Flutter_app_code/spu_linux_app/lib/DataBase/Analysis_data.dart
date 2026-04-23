import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

class AnalysisModel {
  final List<double> xPoints;
  final List<double> yPoints;

  AnalysisModel({required this.xPoints, required this.yPoints});

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    final analysis = json["Analysis"] as Map<String, dynamic>? ?? {};

    return AnalysisModel(
      xPoints: List<double>.from(
        (analysis["x_points"] ?? []).map((e) => e.toDouble()),
      ),
      yPoints: List<double>.from(
        (analysis["y_points"] ?? []).map((e) => e.toDouble()),
      ),
    );
  }
}

// 🔥 empty safe model
AnalysisModel noneAnalysisModel = AnalysisModel(xPoints: [], yPoints: []);

// 📡 load file
Future<AnalysisModel> loadAnalysisFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return noneAnalysisModel;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      return noneAnalysisModel;
    }

    final jsonResult = jsonDecode(data);

    return AnalysisModel.fromJson(jsonResult);
  } catch (e) {
    return noneAnalysisModel;
  }
}
List<FlSpot> getSpots(AnalysisModel model) {
  List<FlSpot> spots = [];

  for (int i = 0; i < model.xPoints.length; i++) {
    spots.add(FlSpot(model.xPoints[i], model.yPoints[i]));
  }

  return spots;
}
