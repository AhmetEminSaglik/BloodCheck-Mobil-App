import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineChartDemo2 extends StatelessWidget {
  final List<Color> gradientColors = const [
    CupertinoColors.systemBlue,
    CupertinoColors.systemGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.red,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.70,
              child: LineChart(lineChartData()),
            )
          ],
        ),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
        borderData: FlBorderData(border: Border.all(color: Colors.white)),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 15,
        lineBarsData: [
          LineChartBarData(
              isCurved: true,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                      colors: gradientColors
                          .map((e) => e.withOpacity(0.3))
                          .toList())),
              spots: const [
                FlSpot(0, 3),
                FlSpot(2, 3.5),
                FlSpot(4, 3.1),
                FlSpot(6, 8),
              ]),
          LineChartBarData(
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData:
                  BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
              spots: const [
                FlSpot(6, 8),
                FlSpot(8, 13.7),
                FlSpot(10, 14),
                FlSpot(11, 15),
              ])
        ]);
  }
}
