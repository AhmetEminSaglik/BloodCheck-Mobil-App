import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/enums/EnumLineChartBottomSideTitles.dart';

import '../../model/diesease/BloodResult.dart';

class CustomLineChartDataDaily {
  List<BloodResult> _bloodListData = [];
  late _BloodListSubItems _bloodListSubItems;
  DateTime now = DateTime.now(); //.subtract(Duration(hours:));
  List<_BottomSideTitles> _bottomTitle = [];

  CustomLineChartDataDaily({required List<BloodResult> bloodListData}) {
    _bloodListData = bloodListData;
    _bloodListSubItems = _BloodListSubItems(bloodResultList: bloodListData);
    _createDailyBottomSideTitles();
  }

  void _createDailyBottomSideTitles() {
    int dailyTotalIndexValue = 144;
    int hour = now.hour;
    int minute = now.minute;
    int passed8HoursCounter = (hour / 8).toInt();
    hour %= 8;
    int remainedTime = ((hour * 60 + minute) / 10).toInt();
    print("remainedTime : $remainedTime");
    print("hour  : $hour");
    int dailyTitleLength=EnumLineChartBottomSideDailyTitles.values.length;
    for (int i = 0; i < dailyTitleLength; i++) {
      _bottomTitle.add(_BottomSideTitles(
          index: dailyTotalIndexValue - (remainedTime + ((i) * 6*8)), // 6 : 60/10, 8 : reset in each 8 hours
          text: EnumLineChartBottomSideDailyTitles.getIndexName(
              (passed8HoursCounter - i) % dailyTitleLength)));
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

  List<_BottomSideTitles> get bottomTitle => _bottomTitle;

  _BloodListSubItems get bloodListSubItems => _bloodListSubItems;
}

class _BottomSideTitles {
  late int _index;
  late String _text;

  _BottomSideTitles({required int index, required String text}) {
    _index = index;
    _text = text;
    print(" _BottomSideTitles GELEN INDEX  DEGERI  : $index");
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
  late double dailySpotRange;
  int dailyTotalIndexValue = 144;

  _BloodListSubItems({required List<BloodResult> bloodResultList}) {
    dailySpotRange = (dailyTotalIndexValue / bloodResultList.length).round().toDouble();
    // print('dailySpotRange  range : $dailySpotRange');
    // print('bloodResultList length : ${bloodResultList.length}');
    for (int i = 0; i < bloodResultList.length; i++) {
      print(
          "GELEN DATA  DAILY : ${bloodResultList[i]}  -->Spot X : ${FlSpot(
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
    double diffMinutes = dailyTotalIndexValue - diff.inMinutes / 10;
    // print("--------> DIFFERENCE : $diffMinutes");
    // print("--------> CreatedAt : $itemCreatedAt");
    return diffMinutes;
  }

  List<FlSpot> get calciumResultListFlSpot => _calciumResultListFlSpot;

  List<FlSpot> get magnesiumResultListFlSpot => _magnesiumResultListFlSpot;

  List<FlSpot> get bloodPressureResultListFlSpot =>
      _bloodPressureResultListFlSpot;

  List<FlSpot> get bloodSugarResultListFlSpot => _bloodSugarResultListFlSpot;
}
