import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/LineChartData/BottomSideTitle.dart';

import '../../../../model/LineChartData/BloodListSubItemsFlSpot.dart';
import '../../../../model/diesease/BloodResult.dart';

abstract class BaseLineChartData {
  List<BloodResult> _bloodResultList = [];
  late BloodListSubItemsFlSpot _bloodListSubItemsFlSpot;
  List<BottomSideTitle> bottomTitle = [];
  DateTime now = DateTime.now(); //.subtract(Duration(hours:));
  late int _rangeTotalIndexValue;

  BaseLineChartData(
      {required List<BloodResult> bloodResultList,
      required int rangeTotalIndexValue}) {
    _rangeTotalIndexValue = rangeTotalIndexValue;
    _bloodResultList = bloodResultList;
    if (_bloodResultList.isNotEmpty) {
      _bloodListSubItemsFlSpot =
          BloodListSubItemsFlSpot(bloodResultList: _bloodResultList);
      print(" simdi bloodList sub itemler setlencek  :");
      setBloodListSubItemsFlSpotValue();
    } else {
      print("BloodResult list Is EMPTY,  SNACKBAR MESSAGE WILL BE SHOWN UP");
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //     CustomSnackBar.getSnackBar("Not Found Any Blood Result Data"));
    }
    createBottomSideTitles();
  }

  // void setBloodListSubItemsFlSpotValue();
  void setBloodListSubItemsFlSpotValue() {
    // print("gelen bloodList.length : ${bloodResultList.length}");
    bloodListSubItemsFlSpot.bloodResultList.forEach((tmp) {
      // print("For each on item : ${tmp}");
      bloodListSubItemsFlSpot.bloodSugarList
          .add(getFlSpotOfItem(tmp.bloodSugar, tmp.createdAt));
      bloodListSubItemsFlSpot.bloodPressureList
          .add(getFlSpotOfItem(tmp.bloodPresure, tmp.createdAt));
      bloodListSubItemsFlSpot.magnesiumList
          .add(getFlSpotOfItem(tmp.magnesium, tmp.createdAt));
      bloodListSubItemsFlSpot.calciumList
          .add(getFlSpotOfItem(tmp.calcium, tmp.createdAt));
    });
    // print("bloodListSubItemsFlSpot.bloodSugarList  :");
    bloodListSubItemsFlSpot.bloodSugarList.forEach((element) {
      // print("elemtn : $element");
    });
  }

  void createBottomSideTitles();

  FlSpot getFlSpotOfItem(int itemValue, DateTime createdAt) {
    return FlSpot(
        getItemFlSpotXValue(itemCreatedAt: createdAt), itemValue.toDouble());
  }

  double getItemFlSpotXValue({required DateTime itemCreatedAt});

  BloodListSubItemsFlSpot get bloodListSubItemsFlSpot =>
      _bloodListSubItemsFlSpot;

/*
  set bloodListSubItemsFlSpot(BloodListSubItemsFlSpot value) {
    _bloodListSubItemsFlSpot = value;
  }
*/

  List<BloodResult> get bloodResultList => _bloodResultList;

  int get rangeTotalIndexValue => _rangeTotalIndexValue;

  /*
  set bloodResultList(List<BloodResult> value) {
    _bloodResultList = value;
  }*/
  @override
  String toString() {
    // TODO: implement toString
    return "BaseLineChartData  :";
  }

/*void _createDailyBottomSideTitles() {
    int dailyTotalIndexValue = 144;
    int hour = now.hour;
    int minute = now.minute;
    int passed8HoursCounter = (hour / 8).toInt();
    hour %= 8;
    int remainedTime = ((hour * 60 + minute) / 10).toInt();
    int dailyTitleLength = EnumLineChartBottomSideDailyTitles.values.length;
    for (int i = 0; i < dailyTitleLength; i++) {
      _bottomTitle.add(_BottomSideTitles(
          index: dailyTotalIndexValue - (remainedTime + ((i) * 6 * 8)),
          // 6 : 60/10, 8 : reset in each 8 hours
          text: EnumLineChartBottomSideDailyTitles.getIndexName(
              (passed8HoursCounter - i) % dailyTitleLength)));
    }
  }*/
}

/*
class _BottomSideTitles {
  late int _index;
  late String _text;

  _BottomSideTitles({required int index, required String text}) {
    _index = index;
    _text = text;
    // print(" _BottomSideTitles GELEN INDEX  DEGERI  : $index");
  }

  String get text => _text;

  int get index => _index;
}
*/

/*class _BloodListSubItems {
  DateTime now = DateTime.now();
  List<FlSpot> _bloodSugarResultListFlSpot = [];
  List<FlSpot> _bloodPressureResultListFlSpot = [];
  List<FlSpot> _magnesiumResultListFlSpot = [];
  List<FlSpot> _calciumResultListFlSpot = [];
  late double dailySpotRange;
  int dailyTotalIndexValue = 144;

  _BloodListSubItems({required List<BloodResult> bloodResultList}) {
    dailySpotRange =
        (dailyTotalIndexValue / bloodResultList.length).round().toDouble();
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
    double diffMinutes = dailyTotalIndexValue - diff.inMinutes / 10;
    return diffMinutes;
  }

  List<FlSpot> get calciumResultListFlSpot => _calciumResultListFlSpot;

  List<FlSpot> get magnesiumResultListFlSpot => _magnesiumResultListFlSpot;

  List<FlSpot> get bloodPressureResultListFlSpot =>
      _bloodPressureResultListFlSpot;

  List<FlSpot> get bloodSugarResultListFlSpot => _bloodSugarResultListFlSpot;
}*/
