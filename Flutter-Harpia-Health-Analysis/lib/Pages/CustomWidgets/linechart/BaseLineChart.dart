/*
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/ResponsiveDesign.dart';
import '../../../model/diesease/EnumBloodResultContent.dart';
import '../../../util/ProductColor.dart';
import '../CheckBoxVisibleBloodResultContent.dart';
import 'data/BaseLineChartData.dart';

abstract class BaseLineChart extends StatefulWidget {
  late BaseLineChartData _baseLineChartData;
  late CheckBoxVisibleBloodResultContent _checkBoxVisibleBloodResultContent;
  late LineChartData _lineChartData;

  BaseLineChart(
      {required baseLineChartData,
      required checkBoxVisibleBloodResultContent,
      required lineChartData}) {
    _baseLineChartData = baseLineChartData;
    _checkBoxVisibleBloodResultContent = checkBoxVisibleBloodResultContent;
    _lineChartData = lineChartData;
  }

  @override
  State<BaseLineChart> createState() => _BaseLineChartState();
}

class _BaseLineChartState extends State<BaseLineChart> {
  late bool isVisibleBloodSugar;
  late bool isVisibleBloodPressure;
  late bool isVisibleCalcium;
  late bool isVisibleMagnesium;

  void updateVisibleValues() {
    isVisibleBloodSugar = widget._checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.BLOOD_SUGAR.name]!.showContent;
    isVisibleBloodPressure = widget._checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.BLOOD_PRESSURE.name]!.showContent;
    isVisibleCalcium = widget._checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.CALCIUM.name]!.showContent;
    isVisibleMagnesium = widget._checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.MAGNESIUM.name]!.showContent;
  }

  @override
  Widget build(BuildContext context) {
    updateVisibleValues();
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
                  padding: EdgeInsets.only(
                      right: ResponsiveDesign.getScreenWidth() / 10,
                      top: ResponsiveDesign.getScreenWidth() / 10),
                  child: LineChart(widget._lineChartData),
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
              return value == 0
                  ? FlLine(color: Colors.black, strokeWidth: 3)
                  : FlLine(strokeWidth: 0);
            },
            getDrawingVerticalLine: (value) {
              return value == 0
                  ? FlLine(color: Colors.black, strokeWidth: 3)
                  : FlLine(strokeWidth: 0);
            }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
                reservedSize: ResponsiveDesign.getScreenWidth() / 10,
                showTitles: true,
                interval: 1,
                getTitlesWidget: leftTiles),
          ),
          bottomTitles: AxisTitles(
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
        ),
        lineBarsData: [
          isVisibleBloodSugar
              ? _getBloodSugarLineChartBarData()
              : LineChartBarData(),
          isVisibleBloodPressure
              ? _getBloodPressureLineChartBarData()
              : LineChartBarData(),
          isVisibleCalcium ? _getCalciumLineChartBarData() : LineChartBarData(),
          isVisibleMagnesium
              ? _getMagnesiumLineChartBarData()
              : LineChartBarData(),
        ]);
  }

  LineChartBarData _getBloodSugarLineChartBarData() {
    List<FlSpot> spotsBloodSugar = [];
    for (FlSpot tmp in widget
        // ._customLineChartData.bloodListSubItems.bloodSugarResultListFlSpot) {
        ._baseLineChartData
        .bloodListSubItemsFlSpot
        .bloodSugarList) {
      spotsBloodSugar.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodSugar, color: ProductColor.fLSpotColorBloodSugar);
  }

  LineChartBarData _getBloodPressureLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp in widget
        // ._customLineChartData.bloodListSubItems.bloodPressureResultListFlSpot) {
        ._baseLineChartData
        .bloodListSubItemsFlSpot
        .bloodPressureList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure,
        color: ProductColor.fLSpotColorBloodPressure);
  }

  LineChartBarData _getMagnesiumLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp in widget
        // ._customLineChartData.bloodListSubItems.magnesiumResultListFlSpot) {
        ._baseLineChartData
        .bloodListSubItemsFlSpot
        .magnesiumList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure,
        color: ProductColor.fLSpotColorMagnesium);
  }

  LineChartBarData _getCalciumLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp in widget
        // ._customLineChartData.bloodListSubItems.calciumResultListFlSpot) {
        ._baseLineChartData
        .bloodListSubItemsFlSpot
        .calciumList) {
      // print("gelen calcium degeri : $tmp}");
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure, color: ProductColor.fLSpotColorCalcium);
  }

  LineChartBarData _getLineChartBarDataForSubBloodResultItem(
      {required List<FlSpot> spotValues, required Color color}) {
    return LineChartBarData(
        color: color,
        isCurved: false,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        spots: spotValues);
  }

  Widget bottomTiles(double value, TitleMeta meta) {
    String text = "";
    for (int i = 0; i < widget._baseLineChartData.bottomTitle.length; i++) {
      if (value == widget._baseLineChartData.bottomTitle[i].index) {
        text = widget._baseLineChartData.bottomTitle[i].text;
        break;
      }
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
      case 40:
        text = '40';
        break;
      case 80:
        text = '80';
        break;
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
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
  }

  double getRandomValue(int val) {
    return Random().nextInt(8).toDouble() + val;
  }

  double getRandomValueBloodResult(int val) {
    return Random().nextInt(100).toDouble() + val;
  }
}
*/