import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatefulWidget {
  final List<FlSpot> spots;
  final List<Color> colors;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final bool show;
  final bool show_color_under;
  final List<String> xLabels;
  final List<String> yLabels;
  final TextStyle style;
  final Color point_color;
  final double point_radius;
  final double padding_int_v;
  final double padding_int_h;
  final double spacing;

  const CustomLineChart({
    super.key,
    required this.spots,
    this.colors = const [Color(0xFF00F5D4), Color(0xFF7B2CBF)],
    this.minX = 0,
    this.maxX = 10,
    this.minY = 0,
    this.maxY = 10,
    this.show = true,
    this.xLabels = const [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
    ],
    this.yLabels = const [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
    ],
    this.style = const TextStyle(
      color: Colors.white70,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    ),
    this.show_color_under = true,
    this.point_color = const Color(0xFF00F5D4),
    this.point_radius = 4,
    this.padding_int_v = 2,
    this.padding_int_h = 2,
    this.spacing = 1,
  });

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Expanded(child: LineChart(_mainData()))]);
  }

  String safeXLabel(double value) {
    int index = value.round();
    if (index < 0 || index >= widget.xLabels.length) return "";
    return widget.xLabels[index];
  }

  String safeYLabel(double value) {
    int index = value.round();
    if (index < 0 || index >= widget.yLabels.length) return "";
    return widget.yLabels[index];
  }

  LineChartData _mainData() {
    return LineChartData(
      minX: widget.minX,
      maxX: widget.maxX,
      minY: widget.minY,
      maxY: widget.maxY,
      gridData: const FlGridData(
        show: true,
        drawHorizontalLine: false,
        drawVerticalLine: false,
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          curveSmoothness: 0.35,
          barWidth: 4,
          gradient: LinearGradient(colors: widget.colors),
          belowBarData: BarAreaData(
            show: widget.show_color_under,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: widget.colors.map((c) => c.withOpacity(0.15)).toList(),
            ),
          ),
          dotData: FlDotData(
            show: widget.show,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: widget.point_radius,
                color: widget.point_color,
                strokeWidth: 2,
                strokeColor: const Color(0xFF16192B),
              );
            },
          ),
        ),
      ],
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: widget.spacing == 0 ? 1 : widget.spacing,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(safeXLabel(value), style: widget.style),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: widget.spacing == 0 ? 1 : widget.spacing,
            getTitlesWidget: (value, meta) {
              return Text(safeYLabel(value), style: widget.style);
            },
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
    );
  }
}
