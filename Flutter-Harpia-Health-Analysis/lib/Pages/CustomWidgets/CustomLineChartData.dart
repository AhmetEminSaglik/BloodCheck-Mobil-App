import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_harpia_health_analysis/model/enums/EnumLineChartBottomSideTitles.dart';

import '../../model/diesease/BloodResult.dart';

class CustomLineChartData {
  List<BloodResult> _bloodListData = [];
  late _BloodListSubItems _bloodListSubItems;
  DateTime now = DateTime.now();//.subtract(Duration(hours:));
  List<_BottomSideTitles> _dailyBottomTitle = [];

  CustomLineChartData({required List<BloodResult> bloodListData}) {
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
    int remainedTime = ((hour * 60 + minute)/10).toInt();
    print("remainedTime : $remainedTime");
    print("hour  : $hour");
    // print("passed8HoursCounter : $passed8HoursCounter");
    // print("(passed8HoursCounter - 0)%3) : ${(passed8HoursCounter - 0)%3}");
    // print("(passed8HoursCounter - 1)%3) : ${(passed8HoursCounter - 1)%3}");
    // print("(passed8HoursCounter - 2)%3) : ${(passed8HoursCounter - 2)%3}");
    for (int i = 0; i < 3; i++) {
    // print("(( passed8HoursCounter-$i)*48) : ${(passed8HoursCounter-i)*48}");
      _dailyBottomTitle.add(_BottomSideTitles(
          // index: dailyTotalIndexValue - remainedTime -( passed8HoursCounter-i)*42,
          // index:((remainedTime+ (i*48)))%144,//((( passed8HoursCounter-i)*48-remainedTime ))%144,
          // index:(remainedTime+ ((i+1)*48))%144,
          index:144-(remainedTime+ ((i)*48)),
          text: EnumLineChartBottomSideTitles.getIndexName(
              (passed8HoursCounter - i)%3)));
      // print("0------------ (passed8HoursCounter - i)%3) ${(passed8HoursCounter - i)%3}" );
    }
    print("_dailyBottomTitle length : ${_dailyBottomTitle.length}");
    print("_dailyBottomTitle 0  : ${_dailyBottomTitle[0]._index} ${_dailyBottomTitle[0].text}");
    print("_dailyBottomTitle 1  :  ${_dailyBottomTitle[1]._index} ${_dailyBottomTitle[1].text}");
    print("_dailyBottomTitle 2  :  ${_dailyBottomTitle[2]._index} ${_dailyBottomTitle[2].text}");
    // print("_dailyBottomTitle 3  :  ${_dailyBottomTitle[3]._index} ${_dailyBottomTitle[3].text}");
  }

  List<BloodResult> get bloodListData => _bloodListData;

  List<_BottomSideTitles> get dailyBottomTitle => _dailyBottomTitle;

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
  List<FlSpot> _bloodSugarResultListFlSpot = [];
  List<FlSpot> _bloodPressureResultListFlSpot = [];
  List<FlSpot> _magnesiumResultListFlSpot = [];
  List<FlSpot> _calciumResultListFlSpot = [];

  _BloodListSubItems({required List<BloodResult> bloodResultList}) {
    for (int i = 0; i < bloodResultList.length; i++) {
      print("GELEN DATA : ${bloodResultList[i]}");
      _bloodSugarResultListFlSpot.add(FlSpot(i*8, bloodResultList[i].bloodSugar.toDouble()));
      // _bloodPressureResultListFlSpot.add(FlSpot(x, bloodResultList[i].bloodPresure.toDouble()));
      // _magnesiumResultListFlSpot.add(FlSpot(x, y));
      // _calciumResultListFlSpot.add(FlSpot(x, y));
    }
  }

  List<FlSpot> get calciumResultListFlSpot => _calciumResultListFlSpot;
  List<FlSpot> get magnesiumResultListFlSpot => _magnesiumResultListFlSpot;
  List<FlSpot> get bloodPressureResultListFlSpot => _bloodPressureResultListFlSpot;
  List<FlSpot> get bloodSugarResultListFlSpot => _bloodSugarResultListFlSpot;
}
