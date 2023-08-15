import '../model/diesease/BloodResult.dart';

class UtilBloodResultChartData {
  static List<BloodResult> _bloodResultListMonthly = [];
  static List<BloodResult> _bloodResultListDaily = [];

  static void uploadData(List<BloodResult> bloodResultList) {
    _bloodResultListMonthly = bloodResultList;
    parseAndSetDailyBloodResultData();
  }

  static void parseAndSetDailyBloodResultData() {
    final now = DateTime.now();
    var startTime = now;
    var endTime = now.subtract(const Duration(hours: 24));

    for (int i = 0; i < _bloodResultListMonthly.length; i++) {
      if (_bloodResultListMonthly[i].createdAt.isBefore(startTime) &&
              _bloodResultListMonthly[i].createdAt.isAfter(endTime) ||
          _bloodResultListMonthly[i].createdAt.isAtSameMomentAs(endTime)) {
        _bloodResultListDaily.add(_bloodResultListMonthly[i]);
      } else {
        print("_bloodResultListDaily size : ${_bloodResultListDaily.length}");
        return;
      }
    }
  }

  static List<BloodResult> getDailyDataList() {
    final now = DateTime.now();
    final tmpTime = Duration(minutes: 10);
    // final tmpTime = Duration(hours: 1);
    List<BloodResult> selectedBloodResult = [];
    List<List<BloodResult>> bloodResultGroupList = [];
    List<BloodResult> groupBloodResult = [];
    int counterTimeMinus = 1;
    var startTime = now;
    var endTime = now.subtract(tmpTime * counterTimeMinus);

    for (int i = 0; i < _bloodResultListDaily.length; i++) {
      if (_bloodResultListDaily[i].createdAt.isBefore(startTime) &&
              _bloodResultListDaily[i].createdAt.isAfter(endTime) ||
          _bloodResultListDaily[i].createdAt.isAtSameMomentAs(endTime)) {
        groupBloodResult.add(_bloodResultListDaily[i]);
        print("$i -------->>>>>> data is added : ${_bloodResultListDaily[i]}  start ${startTime} , end : ${endTime}");
        if (i == _bloodResultListDaily.length - 1) {
          bloodResultGroupList.add(groupBloodResult);
        }
      } else {
        i--;
        counterTimeMinus++;
        bloodResultGroupList.add(groupBloodResult);
        groupBloodResult = [];
        startTime = endTime;
        endTime = now.subtract(tmpTime * counterTimeMinus);
      }
    }

    // print("-->>> AES --- >>------------------");
    int counter = 0;
    bloodResultGroupList.forEach((element) {
      counter++;
      print("GROUP : : $counter");
      element.forEach((element) {
        print("------> $element");
      });
    });
    // print("-----------11111111111----");
    bloodResultGroupList.forEach((element) {
      if (element.isNotEmpty) {
        selectedBloodResult.add(element.first);
      }
    });

    // print("-----------222222222222----");
    selectedBloodResult.forEach((element) {
      print("SELECTED ITEM : $element");
    });

    return selectedBloodResult;
  }
}
