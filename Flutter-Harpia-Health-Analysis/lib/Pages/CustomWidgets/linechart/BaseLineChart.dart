import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/predata/BaseLineChartPreData.dart';

import '../../../core/ResponsiveDesign.dart';
import '../../../model/diesease/EnumBloodResultContent.dart';
import '../../../util/ProductColor.dart';
import '../CheckBoxVisibleBloodResultContent.dart';

abstract class BaseLineChart extends StatelessWidget {
  late double _aspectRadio;
  late BaseLineChartPreData _baseLineChartPreData;
  late CheckBoxVisibleBloodResultContent _checkBoxVisibleBloodResultContent;
  late bool isVisibleBloodSugar;
  late bool isVisibleBloodPressure;
  late bool isVisibleCalcium;
  late bool isVisibleMagnesium;
  bool _showFlDotData = false;
  String _extraMsg = "";

  BaseLineChart(
      {required BaseLineChartPreData baseLineChartPreData,
      required CheckBoxVisibleBloodResultContent
          checkBoxVisibleBloodResultContent,
      double aspectRadio = 1.40}) {
    _baseLineChartPreData = baseLineChartPreData;
    _checkBoxVisibleBloodResultContent = checkBoxVisibleBloodResultContent;
    _aspectRadio = aspectRadio;
  }

  void updateVisibleValues() {
    isVisibleBloodSugar = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.BLOOD_SUGAR.name]!.showContent;
    isVisibleBloodPressure = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.BLOOD_PRESSURE.name]!.showContent;
    isVisibleCalcium = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.CALCIUM.name]!.showContent;
    isVisibleMagnesium = _checkBoxVisibleBloodResultContent
        .subItemMap[EnumBloodResultContent.MAGNESIUM.name]!.showContent;
  }

  Widget showDataIsNotFoundText() {
    if (_baseLineChartPreData.bloodResultList.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 50),
        child: Container(
          color: ProductColor.redAccent,
          height: ResponsiveDesign.getScreenHeight() / 15,
          width: ResponsiveDesign.getScreenWidth() -
              ResponsiveDesign.getScreenWidth() / 3.5,
          child: Center(
            child: Text(
              "Data Is Not Found",
              style: TextStyle(
                fontSize: ResponsiveDesign.getScreenWidth() / 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    // return const Text("-");
    return Container();
  }

  Widget showExtraMsgTopOfLineChart({String msg = "Default  Msg"}) {
    print("showExtraMsgTopOfLineChart : GELDI MSG :$msg ");
    if (msg.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 50),
        child: Container(
          color: ProductColor.redAccent,
          height: ResponsiveDesign.getScreenHeight() / 15,
          width: ResponsiveDesign.getScreenWidth() -
              ResponsiveDesign.getScreenWidth() / 3.5,
          child: Center(
            child: Text(
              msg,
              style: TextStyle(
                  fontSize: ResponsiveDesign.getScreenWidth() / 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
    // return const Text("-");
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    updateVisibleValues();
    return Scaffold(
      // backgroundColor:ProductColor.bodyBackgroundLight,
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: ResponsiveDesign.getCertainWidth() / 10),
            child: Column(
              children: [
                showDataIsNotFoundText(),
                showExtraMsgTopOfLineChart(msg: _extraMsg),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: ResponsiveDesign.getScreenWidth() / 30,
                right: ResponsiveDesign.getScreenWidth() / 30,
                top: ResponsiveDesign.getScreenWidth() / 10,
                bottom: ResponsiveDesign.getScreenWidth() / 10,
              ),
              child:
                  LineChart(getLineChartData()), //LineChart(lineChartData()),
            ),
          ),
        ],
      ),
    );
  }

/*  @override

  Widget build(BuildContext context) {
    updateVisibleValues();
    return Scaffold(
      // backgroundColor:ProductColor.bodyBackgroundLight,
      body: Column(
        children: [
          showDataNotFoundText(),
          showExtraMsgTopOfLineChart(msg: _extraMsg),
          Padding(
            padding: EdgeInsets.only(top: ResponsiveDesign.getScreenHeight() / 55),
            child: Container(
              color: Colors.lightGreenAccent,
              // height: 100,
              // width:  ResponsiveDesign.getScreenWidth(),
              width:  ResponsiveDesign.getScreenWidth(),
              child: AspectRatio(
                aspectRatio: _aspectRadio, //1.30,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: ResponsiveDesign.getScreenWidth() / 10,
                      top: ResponsiveDesign.getScreenWidth() / 10),
                  child: LineChart(
                      getLineChartData()), //LineChart(lineChartData()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  LineChartData getLineChartData();

  bool get showFlDotData => _showFlDotData;

  set showFlDotData(bool value) {
    _showFlDotData = value;
  }

  String get extraMsg => _extraMsg;

  set extraMsg(String value) {
    _extraMsg = value;
  }

  BaseLineChartPreData get baseLineChartPreData => _baseLineChartPreData;

  double get aspectRadio => _aspectRadio;

  set aspectRadio(double value) {
    _aspectRadio = value;
  }

  /*LineChartData lineChartData() {
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
  }*/

  LineChartBarData getBloodSugarLineChartBarData() {
    List<FlSpot> spotsBloodSugar = [];
    for (FlSpot tmp in
        // ._customLineChartData.bloodListSubItems.bloodSugarResultListFlSpot) {
        _baseLineChartPreData.bloodListSubItemsFlSpot.bloodSugarList) {
      spotsBloodSugar.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodSugar, color: ProductColor.fLSpotColorBloodSugar);
  }

  LineChartBarData getBloodPressureLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp in
        // ._customLineChartData.bloodListSubItems.bloodPressureResultListFlSpot) {
        _baseLineChartPreData.bloodListSubItemsFlSpot.bloodPressureList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure,
        color: ProductColor.fLSpotColorBloodPressure);
  }

  LineChartBarData getMagnesiumLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp in
        // ._customLineChartData.bloodListSubItems.magnesiumResultListFlSpot) {
        _baseLineChartPreData.bloodListSubItemsFlSpot.magnesiumList) {
      spotsBloodPressure.add(tmp);
    }

    return _getLineChartBarDataForSubBloodResultItem(
        spotValues: spotsBloodPressure,
        color: ProductColor.fLSpotColorMagnesium);
  }

  LineChartBarData getCalciumLineChartBarData() {
    List<FlSpot> spotsBloodPressure = [];
    for (FlSpot tmp in
        // ._customLineChartData.bloodListSubItems.calciumResultListFlSpot) {
        _baseLineChartPreData.bloodListSubItemsFlSpot.calciumList) {
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
        dotData: FlDotData(show: _showFlDotData),
        spots: spotValues);
  }

  Widget getBottomSideTiles(double value, TitleMeta meta) {
    String text = "";
    for (int i = 0; i < _baseLineChartPreData.bottomTitle.length; i++) {
      if (value == _baseLineChartPreData.bottomTitle[i].index) {
        text = _baseLineChartPreData.bottomTitle[i].text;
        break;
      }
    }
    return Text(
      text,
      style: axisTextStyle(),
      textAlign: TextAlign.left,
    );
  }

  Widget getLeftSideTiles(double value, TitleMeta meta) {
    String text = "";
    for (int i = 0; i < _baseLineChartPreData.leftTitle.length; i++) {
      if (value == _baseLineChartPreData.leftTitle[i].index) {
        text = _baseLineChartPreData.leftTitle[i].text;
        break;
      }
    }
    return Text(
      text,
      style: axisTextStyle(),
      textAlign: TextAlign.left,
    );
  }

  /*Widget leftTiles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      default:
        return const Text("");
    }
    return Text(
      text,
      style: axisTextStyle(),
      textAlign: TextAlign.left,
    );
  }*/

  TextStyle axisTextStyle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
  }
}
