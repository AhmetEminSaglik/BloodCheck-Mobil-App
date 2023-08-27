/*
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/enums/linechart/bottomtitles/EnumLineChartBottomSideWeeklyTitles.dart';

import '../../model/diesease/BloodResult.dart';

class CustomLineChartDataWeekly {
  List<BloodResult> _bloodListData = [];
  late _BloodListSubItems _bloodListSubItems;
  DateTime now = DateTime.now(); //.subtract(Duration(hours:));
  List<_BottomSideTitles> _bottomTitle = [];

  CustomLineChartDataWeekly({required List<BloodResult> bloodListData}) {
    _bloodListData = bloodListData;
    _bloodListSubItems = _BloodListSubItems(bloodResultList: bloodListData);
    _createWeeklyBottomSideTitles();
  }

  void _createWeeklyBottomSideTitles() {
    int weeklyTotalIndexValue = 168;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;
    int passedDayCounter = (day % 7).toInt();
    day %= 7;
    int remainedTime = ((hour * 60 + minute) / 60).toInt();
    int weeklyTitleLength = EnumLineChartBottomSideWeeklyTitles.values.length;
    for (int i = 0; i < weeklyTitleLength; i++) {
      _bottomTitle.add(_BottomSideTitles(
          index: weeklyTotalIndexValue - (remainedTime + ((i) * 24)), //24 : reset each 24 hours
          text: EnumLineChartBottomSideWeeklyTitles.getIndexName(
              (passedDayCounter - i) % weeklyTitleLength)));
    }
  }

  List<BloodResult> get bloodListData => _bloodListData;

  List<_BottomSideTitles> get weeklyBottomTitle => _bottomTitle;

  _BloodListSubItems get bloodListSubItems => _bloodListSubItems;
}

class _BottomSideTitles {
  late int _index;
  late String _text;

  _BottomSideTitles({required int index, required String text}) {
    _index = index;
    _text = text;
  }

  String get text => _text;

  int get index => _index;
}

class _BloodListSubItems {
  DateTime now = DateTime.now();
  List<FlSpot> _bloodSugarResultListFlSpot = [];
  List<FlSpot> _bloodPressureResultListFlSpot = [];
  List<FlSpot> _magnesiumResultListFlSpot = [];
  List<FlSpot> _calciumResultListFlSpot = [];
  late double weeklySpotRange;
  int weeklyTotalIndexValue = 168;

  _BloodListSubItems({required List<BloodResult> bloodResultList}) {
    weeklySpotRange =
        (weeklyTotalIndexValue / bloodResultList.length).round().toDouble();
    // print('weeklySpotRange  range : $weeklySpotRange');
    // print('bloodResultList length : ${bloodResultList.length}');
    for (int i = 0; i < bloodResultList.length; i++) {
      // print(
      //     "GELEN DATA WEEKLY : ${bloodResultList[i]}  -->Spot X : ${FlSpot(_getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt), bloodResultList[i].bloodSugar.toDouble())}");
      _bloodSugarResultListFlSpot.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].bloodSugar.toDouble()));

      _bloodPressureResultListFlSpot.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].bloodPresure.toDouble()));

      _calciumResultListFlSpot.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].calcium.toDouble()));

      _magnesiumResultListFlSpot.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].magnesium.toDouble()));
    }
  }

  double _getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (weeklyTotalIndexValue - diff.inHours).toDouble();
    return diffHours;
  }

  List<FlSpot> get calciumResultListFlSpot => _calciumResultListFlSpot;

  List<FlSpot> get magnesiumResultListFlSpot => _magnesiumResultListFlSpot;

  List<FlSpot> get bloodPressureResultListFlSpot =>
      _bloodPressureResultListFlSpot;

  List<FlSpot> get bloodSugarResultListFlSpot => _bloodSugarResultListFlSpot;
}
*/
