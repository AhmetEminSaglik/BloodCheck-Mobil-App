import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/ResponsiveDesign.dart';

class LineChartDaily extends StatelessWidget {
  final List<Color> gradientColors = const [
    CupertinoColors.systemBlue,
    CupertinoColors.systemGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ResponsiveDesign.getScreenHeight() / 100),
        child: Container(
          // color: Colors.red,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.50,
                child: LineChart(lineChartData()),
              )
            ],
          ),
        ),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData(
        borderData: FlBorderData(border: Border.all(color: Colors.white)),
        minX: -1,
        maxX: 1440,
        minY: -1,
        maxY: 150,
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              // return FlLine(color: Colors.green, strokeWidth: 1);
              return value == 0
                  ? FlLine(color: Colors.black, strokeWidth: 3)
                  : FlLine(strokeWidth: 0);
            },
            getDrawingVerticalLine: (value) {
              // return FlLine(color: Colors.black, strokeWidth: 1);
              // print("VLAUE : $value");
              return value == 0
                  ? FlLine(color: Colors.black, strokeWidth: 3)
                  : FlLine(strokeWidth: 0);
            }),
        /*  gridData: FlGridData(
          show: false
        ),*/
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            // axisNameWidget: CustomWidget(),
            sideTitles: SideTitles(
                reservedSize: ResponsiveDesign.getScreenWidth() / 10,
                showTitles: true,
                interval: 1,
                getTitlesWidget: leftTiles),
          ),
          bottomTitles: AxisTitles(
            // axisNameSize: 1000,
            // axisNameWidget: CustomWidget(),
            sideTitles: SideTitles(
                reservedSize: ResponsiveDesign.getScreenHeight() / 40,
                interval: 1,
                showTitles: true,
                getTitlesWidget: bottomTiles),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),

          /*leftTitles: SideTitles(showTitles: true),
        bottomTitles: SideTitles(showTitles: true),*/
        ),
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
              spots: [
                FlSpot(10, getRandomValueBloodResult(0)),
                FlSpot(300, getRandomValueBloodResult(0)),
                FlSpot(600, getRandomValueBloodResult(0)),
                FlSpot(900, getRandomValueBloodResult(0)),
                FlSpot(1400, getRandomValueBloodResult(0)),
              ]),
/*          LineChartBarData(
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData:
                  BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
              spots: [
                FlSpot(6, getRandomValue(8)),
                FlSpot(8, getRandomValue(8)),
                FlSpot(10, getRandomValue(8)),
                FlSpot(11, getRandomValue(8)),
              ])*/
        ]);
  }
}

Widget bottomTiles(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 20:
      text = '00:00'; //500
      break;
    case 380:
      text = '06:00';
      break;
    case 740:
      text = '12:00';
      break;
    case 1100:
      text = '18:00';
      break;
    default:
      return Text("");
  }
  return Text(
    text,
    style: axisTextStyle(),
    textAlign: TextAlign.left,
  );
}

Widget leftTiles(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    // case 20:
    //   text = '20';
    //   break;
    case 40:
      text = '40';
      break;
    // case 60:
    //   text = '60';
    //   break;
    case 80:
      text = '80';
      break;
    // case 100:
    //   text = '100';
    //   break;
    case 120:
      text = '120';
      break;
    default:
      return Text("");
  }
  return Text(
    text,
    style: axisTextStyle(),
    textAlign: TextAlign.left,
  );
}

TextStyle axisTextStyle() {
  return TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
}

double getRandomValue(int val) {
  return Random().nextInt(8).toDouble() + val;
}

double getRandomValueBloodResult(int val) {
  return Random().nextInt(100).toDouble() + val;
}
