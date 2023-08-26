import 'package:fl_chart/fl_chart.dart';

import '../diesease/BloodResult.dart';

class BloodListSubItemsFlSpot{

  DateTime now = DateTime.now();

  List<BloodResult> _bloodResultList= [];
  List<FlSpot> _bloodSugarList= [];
  List<FlSpot> _bloodPressureList = [];
  List<FlSpot> _calciumList = [];
  List<FlSpot> _magnesiumList = [];
  // late double dailySpotRange;
  int dailyTotalIndexValue = 144;

  BloodListSubItemsFlSpot({required List<BloodResult> bloodResultList}) {
    _bloodResultList=bloodResultList;
    /*
    // dailySpotRange =
    //     (dailyTotalIndexValue / bloodResultList.length).round().toDouble();
    for (int i = 0; i < bloodResultList.length; i++) {
      _bloodSugarList.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].bloodSugar.toDouble()));

      _bloodPressureList.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].bloodPresure.toDouble()));

      _calciumList.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].calcium.toDouble()));

      _magnesiumList.add(FlSpot(
          _getItemFlSpotXValue(itemCreatedAt: bloodResultList[i].createdAt),
          bloodResultList[i].magnesium.toDouble()));
    }*/
  }

  /*double _getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffMinutes = dailyTotalIndexValue - diff.inMinutes / 10;
    return diffMinutes;
  }*/
  List<BloodResult> get bloodResultList => _bloodResultList;

  List<FlSpot> get magnesiumList => _magnesiumList;

  List<FlSpot> get calciumList => _calciumList;

  List<FlSpot> get bloodPressureList => _bloodPressureList;

  List<FlSpot> get bloodSugarList => _bloodSugarList;

}