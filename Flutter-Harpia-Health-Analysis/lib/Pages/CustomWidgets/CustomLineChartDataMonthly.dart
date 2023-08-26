import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/enums/linechart/bottomtitles/EnumLineChartBottomSideMonthlyTitles.dart';
import 'package:flutter_harpia_health_analysis/model/enums/linechart/bottomtitles/EnumLineChartBottomSideWeeklyTitles.dart';

import '../../model/diesease/BloodResult.dart';

class CustomLineChartDataMonthly {
  List<BloodResult> _bloodListData = [];
  late _BloodListSubItems _bloodListSubItems;
  DateTime now = DateTime.now().add(Duration(days: 3));
  List<_BottomSideTitles> _bottomTitle = [];

  CustomLineChartDataMonthly({required List<BloodResult> bloodListData}) {
    _bloodListData = bloodListData;
    _bloodListSubItems = _BloodListSubItems(bloodResultList: bloodListData);
    _createWeeklyBottomSideTitles();
  }

  void _createWeeklyBottomSideTitles() {
    int monthlyTotalIndexValue = 180;
    int day = now.day;
    int hour = now.hour;
    int passedWeekCounter = (day / 7).toInt();
    day %= 7;
    double remainedTime = ((day * 24 + hour) / 24);
    int monthlyTitleLength = EnumLineChartBottomSideMonthlyTitles.values.length;
    for (int i = 0; i <= monthlyTitleLength; i++) {
      _bottomTitle.add(_BottomSideTitles(
          index: (monthlyTotalIndexValue - (remainedTime + ((i) * 6 * 7)))
              .toInt(), // test each 6 hours and one week is 7 days. ==> 6*7
          text: EnumLineChartBottomSideMonthlyTitles.getIndexName(
              (passedWeekCounter - i) % monthlyTitleLength)));
    }
  }

  List<BloodResult> get bloodListData => _bloodListData;

  List<_BottomSideTitles> get monthlyBottomTitle => _bottomTitle;

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
  late double monthlySpotRange;
  int monthlyTotalIndexValue = 168;

  _BloodListSubItems({required List<BloodResult> bloodResultList}) {
    monthlySpotRange =
        (monthlyTotalIndexValue / bloodResultList.length).round().toDouble();
    for (int i = 0; i < bloodResultList.length; i++) {
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
    double diffHours = (monthlyTotalIndexValue - diff.inHours / 4)
        .toDouble(); // each 4 hours, add a new bloodResult Data
    return diffHours;
  }

  List<FlSpot> get calciumResultListFlSpot => _calciumResultListFlSpot;

  List<FlSpot> get magnesiumResultListFlSpot => _magnesiumResultListFlSpot;

  List<FlSpot> get bloodPressureResultListFlSpot =>
      _bloodPressureResultListFlSpot;

  List<FlSpot> get bloodSugarResultListFlSpot => _bloodSugarResultListFlSpot;
}
