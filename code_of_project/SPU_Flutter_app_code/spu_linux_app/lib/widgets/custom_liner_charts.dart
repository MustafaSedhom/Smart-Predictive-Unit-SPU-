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
  // ignore: non_constant_identifier_names
  final bool show_color_under;
  final List<String> xLabels;
  final List<String> yLabels;
  final TextStyle style;
  // ignore: non_constant_identifier_names
  final Color point_color;
  // ignore: non_constant_identifier_names
  final double point_radius;
  // ignore: non_constant_identifier_names
  final double padding_int_v;
  // ignore: non_constant_identifier_names
  final double padding_int_h;
  const CustomLineChart({
    super.key,
    required this.spots,
    this.colors = const [
      Colors.red,
      Colors.orange,
      Colors.green,
      Colors.blue,
      Colors.deepPurple,
    ],
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
    this.style = const TextStyle(color: Colors.white),
    // ignore: non_constant_identifier_names
    this.show_color_under = true,
    // ignore: non_constant_identifier_names
    this.point_color = Colors.white,
    // ignore: non_constant_identifier_names
    this.point_radius = 5,
    // ignore: non_constant_identifier_names
    this.padding_int_v = 2,
    // ignore: non_constant_identifier_names
    this.padding_int_h = 2,
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

      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          barWidth: 5,
          color: Colors.amber,
          gradient: LinearGradient(colors: widget.colors),
          belowBarData: BarAreaData(
            show: widget.show_color_under,
            gradient: LinearGradient(
              // ignore: deprecated_member_use
              colors: widget.colors.map((c) => c.withOpacity(0.3)).toList(),
            ),
          ),
          dotData: FlDotData(
            show: widget.show,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: widget.point_radius,
                color: widget.point_color,
                strokeWidth: 0,
                strokeColor: Colors.blue,
              );
            },
          ),
        ),
      ],
      titlesData: FlTitlesData(
        //  X axis
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text(safeXLabel(value), style: widget.style);
            },
          ),
        ),

        //  Y axis
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return Text(safeYLabel(value), style: widget.style);
            },
          ),
        ),

        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
      ),
    );
  }
}
