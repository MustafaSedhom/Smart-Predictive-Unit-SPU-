// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:spu_linux_app/DataBase/json_file_path.dart';

///////////////////////////////////////////////////////////////////////
///// read point analysis data
class PointAnalysisModel {
  final List<double> xPoints;
  final List<double> yPoints;

  PointAnalysisModel({required this.xPoints, required this.yPoints});

  factory PointAnalysisModel.fromJson(Map<String, dynamic> json) {
    final points = json["Analysis"]?["points"] as Map<String, dynamic>? ?? {};

    return PointAnalysisModel(
      xPoints: List<double>.from(
        (points["x_points"] ?? []).map((e) => e.toDouble()),
      ),
      yPoints: List<double>.from(
        (points["y_points"] ?? []).map((e) => e.toDouble()),
      ),
    );
  }
}

//  empty safe model
PointAnalysisModel nonePointAnalysisModel = PointAnalysisModel(
  xPoints: [],
  yPoints: [],
);

//  load file
Future<PointAnalysisModel> loadPointAnalysisFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return nonePointAnalysisModel;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      return nonePointAnalysisModel;
    }

    final jsonResult = jsonDecode(data);

    return PointAnalysisModel.fromJson(jsonResult);
  } catch (e) {
    return nonePointAnalysisModel;
  }
}

List<FlSpot> getSpots(PointAnalysisModel model) {
  List<FlSpot> spots = [];

  for (int i = 0; i < model.xPoints.length; i++) {
    spots.add(FlSpot(model.xPoints[i], model.yPoints[i]));
  }

  return spots;
}

///////////////////////////////////////////////////////////////////////
///// read point analysis data
class LabelAnalysisModel {
  final List<String> xPoints;
  final List<String> yPoints;

  LabelAnalysisModel({required this.xPoints, required this.yPoints});

  factory LabelAnalysisModel.fromJson(Map<String, dynamic> json) {
    final points = json["Analysis"]?["labels"] as Map<String, dynamic>? ?? {};

    return LabelAnalysisModel(
      xPoints: List<String>.from(
        (points["x_labels"] ?? []).map((e) => e.toString()),
      ),
      yPoints: List<String>.from(
        (points["y_labels"] ?? []).map((e) => e.toString()),
      ),
    );
  }
}

// empty safe model
LabelAnalysisModel none_label_analysis = LabelAnalysisModel(
  xPoints: [],
  yPoints: [],
);

// load file
Future<LabelAnalysisModel> loadLabelAnalysisFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return none_label_analysis;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      return none_label_analysis;
    }

    final jsonResult = jsonDecode(data);

    return LabelAnalysisModel.fromJson(jsonResult);
  } catch (e) {
    return none_label_analysis;
  }
}

///////////////////////////////////////////////////////////////////////
///// read point analysis data
class AnalysisSpacing {
  final double Spacing;
  AnalysisSpacing({this.Spacing = 0});
  factory AnalysisSpacing.fromJson(Map<String, dynamic> json) {
    final space_data = json["Analysis"]?["Spacing"] as double? ?? 0;
    return AnalysisSpacing(Spacing: space_data);
  }
}

AnalysisSpacing none_analysis_spacing = AnalysisSpacing(Spacing: 0);

// load file
Future<AnalysisSpacing> loadAnalysisSpacingFromFile() async {
  try {
    if (JsonFilePath.path == null || JsonFilePath.path!.isEmpty) {
      throw Exception("File path is not set");
    }

    final file = File(JsonFilePath.path!);

    if (!await file.exists()) {
      return none_analysis_spacing;
    }

    final data = await file.readAsString();

    if (data.isEmpty) {
      return none_analysis_spacing;
    }

    final jsonResult = jsonDecode(data);

    return AnalysisSpacing.fromJson(jsonResult);
  } catch (e) {
    return none_analysis_spacing;
  }
}
