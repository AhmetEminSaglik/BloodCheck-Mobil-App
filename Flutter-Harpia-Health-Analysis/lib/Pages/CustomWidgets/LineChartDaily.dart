import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

import '../../core/ResponsiveDesign.dart';
import 'CustomLineChartData.dart';

class LineChartDaily extends StatefulWidget {
  late CustomLineChartData _customLineChartData;

  LineChartDaily({required CustomLineChartData customLineChartData}) {
    _customLineChartData = customLineChartData;
  }

  @override
  State<LineChartDaily> createState() => _LineChartDailyState();
}

class _LineChartDailyState extends State<LineChartDaily> {
  final List<Color> gradientColors = const [
    CupertinoColors.systemBlue,
    CupertinoColors.systemGreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:ProductColor.bodyBackgroundLight,
      body: Padding(
        padding: EdgeInsets.all(ResponsiveDesign.getScreenHeight() / 100),
        child: Container(
          // color: Colors.red,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.40,
                child: Padding(
                  padding: EdgeInsets.only(right:ResponsiveDesign.getScreenWidth()/10,top:ResponsiveDesign.getScreenWidth()/10),
                  child: LineChart(lineChartData()),
                ),
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
        maxX: 144,
        minY: -1,
        maxY: 200,
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
          getLineChartBarData(),
          /*   LineChartBarData(
              isCurved: false,
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
                FlSpot(20, getRandomValueBloodResult(0)),
                FlSpot(30, getRandomValueBloodResult(0)),
                FlSpot(40, getRandomValueBloodResult(0)),
                FlSpot(50, getRandomValueBloodResult(0)),
              ]),*/
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

  LineChartBarData getLineChartBarData() {
    List<FlSpot> spotsBloodSugar = [];
    for (int i = 0; i < widget._customLineChartData.bloodListData.length; i++) {
      spotsBloodSugar.add(widget._customLineChartData.bloodListSubItems
          .bloodSugarResultListFlSpot[i]);
    }

    return LineChartBarData(
        isCurved: false,
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                colors:
                    gradientColors.map((e) => e.withOpacity(0.3)).toList())),
        spots: spotsBloodSugar);
  }

  Widget bottomTiles(double value, TitleMeta meta) {
    // widget._customLineChartData.dailyBottomTitle[0].index;
    String text = "";
    for (int i = 0;
        i < widget._customLineChartData.dailyBottomTitle.length;
        i++) {
      if (value == widget._customLineChartData.dailyBottomTitle[i].index) {
        text = widget._customLineChartData.dailyBottomTitle[i].text;
        break;
      }
    }
/*    String text;
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
    }*/
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
}
