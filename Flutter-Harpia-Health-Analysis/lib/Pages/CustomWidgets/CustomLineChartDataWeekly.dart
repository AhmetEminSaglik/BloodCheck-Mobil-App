import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/enums/EnumLineChartBottomSideWeeklyTitles.dart';

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
    print("before process : day : $day / hour $hour / minute :$minute");
    int passedDayCounter = (day % 7).toInt();
    day %= 7;
    int remainedTime = ((hour * 60 + minute) / 60).toInt();
    print("remainedTime : $remainedTime");
    print("day  : $day");
    print("hour  : $hour");
    print("minute  : $minute");
    int weeklyTitleLength = EnumLineChartBottomSideWeeklyTitles.values.length;
    for (int i = 0; i < weeklyTitleLength; i++) {
      _bottomTitle.add(_BottomSideTitles(
          index: weeklyTotalIndexValue - (remainedTime + ((i) * 24)),
          text: EnumLineChartBottomSideWeeklyTitles.getIndexName(
              (passedDayCounter - i) % weeklyTitleLength)));
    }
    print("_bottomTitle length : ${_bottomTitle.length}");
    print(
        "_bottomTitle 0  : ${_bottomTitle[0]._index} ${_bottomTitle[0].text}");
    print(
        "_bottomTitle 1  :  ${_bottomTitle[1]._index} ${_bottomTitle[1].text}");
    print(
        "_bottomTitle 2  :  ${_bottomTitle[2]._index} ${_bottomTitle[2].text}");
    // print("_bottomTitle 3  :  ${_bottomTitle[3]._index} ${_bottomTitle[3].text}");
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
    weeklySpotRange = (weeklyTotalIndexValue / bloodResultList.length).round().toDouble();
    // print('weeklySpotRange  range : $weeklySpotRange');
    // print('bloodResultList length : ${bloodResultList.length}');
    for (int i = 0; i < bloodResultList.length; i++) {
      print(
          "GELEN DATA WEEKLY : ${bloodResultList[i]}  -->Spot X : ${FlSpot(
              _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
              bloodResultList[i].bloodSugar.toDouble())}");
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

      // _bloodPressureResultListFlSpot.add(FlSpot(x, bloodResultList[i].bloodPresure.toDouble()));
      // _magnesiumResultListFlSpot.add(FlSpot(x, y));
      // _calciumResultListFlSpot.add(FlSpot(x, y));
    }
  }

  double _getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours =( weeklyTotalIndexValue - diff.inHours).toDouble();
    print("--------> diff TIMES  : $diff");
    print("--------> DIFFERENCE : $diffHours");
    // print("--------> CreatedAt : $itemCreatedAt");
    return diffHours;
  }

  List<FlSpot> get calciumResultListFlSpot => _calciumResultListFlSpot;

  List<FlSpot> get magnesiumResultListFlSpot => _magnesiumResultListFlSpot;

  List<FlSpot> get bloodPressureResultListFlSpot =>
      _bloodPressureResultListFlSpot;

  List<FlSpot> get bloodSugarResultListFlSpot => _bloodSugarResultListFlSpot;
}
