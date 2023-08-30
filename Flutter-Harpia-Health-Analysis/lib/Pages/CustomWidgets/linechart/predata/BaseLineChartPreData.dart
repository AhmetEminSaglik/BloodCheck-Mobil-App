import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/LineChartData/LineChartSideTitle.dart';
import 'dart:math';
import '../../../../model/LineChartData/BloodListSubItemsFlSpot.dart';
import '../../../../model/bloodresult/BloodResult.dart';

abstract class BaseLineChartPreData {
  List<BloodResult> _bloodResultList = [];
  BloodListSubItemsFlSpot _bloodListSubItemsFlSpot =
      BloodListSubItemsFlSpot(bloodResultList: []);
  List<LineChartSideTitle> bottomTitle = [];
  List<LineChartSideTitle> leftTitle = [];

  DateTime now = DateTime.now();
  late int _rangeTotalIndexValue;

  late double _lineChartMinY;
  late double _lineChartMaxY;
  late int _minY, _maxY;

  BaseLineChartPreData(
      {required List<BloodResult> bloodResultList,
      required int rangeTotalIndexValue}) {
    _rangeTotalIndexValue = rangeTotalIndexValue;
    _bloodResultList = bloodResultList;
    if (_bloodResultList.isNotEmpty) {
      _bloodListSubItemsFlSpot =
          BloodListSubItemsFlSpot(bloodResultList: _bloodResultList);
      setBloodListSubItemsFlSpotValue();
    }

    createLeftSideTitles();
    createBottomSideTitles();
  }

  void setBloodListSubItemsFlSpotValue() {
    List<int> yIndexValue = [];
    print("bloodResultList length: ${bloodListSubItemsFlSpot.bloodResultList.length} ");
    print("rangeTotalIndexValue : $rangeTotalIndexValue ");
    for (int i = 0; i < bloodListSubItemsFlSpot.bloodResultList.length; i++) {
      BloodResult tmp = bloodListSubItemsFlSpot.bloodResultList[i];

      bloodListSubItemsFlSpot.bloodSugarList.add(getFlSpotOfItem(
        index: i,
        itemValue: tmp.bloodSugar,
      ));
      print(
          "------------ >  $i-) BLOOD SUGAR SPOT : ${getFlSpotOfItem(index: i, itemValue: tmp.bloodSugar)}");
      bloodListSubItemsFlSpot.bloodPressureList.add(getFlSpotOfItem(
        index: i,
        itemValue: tmp.bloodPresure,
      ));
      bloodListSubItemsFlSpot.magnesiumList.add(getFlSpotOfItem(
        index: i,
        itemValue: tmp.magnesium,
      ));
      bloodListSubItemsFlSpot.calciumList.add(getFlSpotOfItem(
        index: i,
        itemValue: tmp.calcium,
      ));

      yIndexValue.add(tmp.bloodSugar);
      yIndexValue.add(tmp.bloodPresure);
      yIndexValue.add(tmp.calcium);
      yIndexValue.add(tmp.magnesium);
    }
    /* bloodListSubItemsFlSpot.bloodResultList.forEach((tmp) {
      bloodListSubItemsFlSpot.bloodSugarList
          .add(getFlSpotOfItem(tmp.bloodSugar, tmp.createdAt));

      print(
          "------------ >  BLOOD SUGAR SPOT : ${getFlSpotOfItem(tmp.bloodSugar, tmp.createdAt)}");
      bloodListSubItemsFlSpot.bloodPressureList
          .add(getFlSpotOfItem(tmp.bloodPresure, tmp.createdAt));
      bloodListSubItemsFlSpot.magnesiumList
          .add(getFlSpotOfItem(tmp.magnesium, tmp.createdAt));
      bloodListSubItemsFlSpot.calciumList
          .add(getFlSpotOfItem(tmp.calcium, tmp.createdAt));

      yIndexValue.add(tmp.bloodSugar);
      yIndexValue.add(tmp.bloodPresure);
      yIndexValue.add(tmp.calcium);
      yIndexValue.add(tmp.magnesium);
    });*/
    _minY = yIndexValue.reduce(min);
    _maxY = yIndexValue.reduce(max);
    _lineChartMaxY = _maxY + 25;
    _lineChartMinY = _minY - 25;
    bloodListSubItemsFlSpot.bloodSugarList.forEach((element) {});
  }

  void createBottomSideTitles();

  void createLeftSideTitles() {
    if (bloodResultList.isEmpty) {
      _lineChartMinY = 0;
      _minY = 25;
      _maxY = 75;
      _lineChartMaxY = 100;
    }
    int average = (_minY + _maxY) ~/ 2;
    leftTitle.add(LineChartSideTitle(
        index: _lineChartMinY.toInt(),
        text: _lineChartMinY.toInt().toString()));
    leftTitle.add(LineChartSideTitle(index: _minY, text: _minY.toString()));
    leftTitle.add(LineChartSideTitle(index: average, text: average.toString()));
    leftTitle.add(LineChartSideTitle(index: _maxY, text: _maxY.toString()));
    leftTitle.add(LineChartSideTitle(
        index: _lineChartMaxY.toInt(),
        text: _lineChartMaxY.toInt().toString()));
  }

  FlSpot getFlSpotOfItem({required int index, required int itemValue}) {
    return FlSpot(getItemFlSpotXValue(index: index), itemValue.toDouble());
  }

  // double getItemFlSpotXValue({required DateTime itemCreatedAt});
  double getItemFlSpotXValue({required int index}) {
    return (rangeTotalIndexValue - index).toDouble();
  }

  BloodListSubItemsFlSpot get bloodListSubItemsFlSpot =>
      _bloodListSubItemsFlSpot;

  List<BloodResult> get bloodResultList => _bloodResultList;

  int get rangeTotalIndexValue => _rangeTotalIndexValue;

  double get lineChartMinY => _lineChartMinY;

  @override
  String toString() {
    return "BaseLineChartPreData  :";
  }

  double get lineChartMaxY => _lineChartMaxY;
}
