import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/data/BaseLineChartData.dart';

import '../../../../model/LineChartData/BottomSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideTitles.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideWeeklyTitles.dart';

class LineChartDataWeekly extends BaseLineChartData {
  LineChartDataWeekly({required super.bloodResultList})
      : super(rangeTotalIndexValue: 168);

  @override
  void createBottomSideTitles() {
    int weeklyTotalIndexValue = rangeTotalIndexValue;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;
    int passedDayCounter = (day % 7).toInt();
    day %= 7;
    int remainedTime = ((hour * 60 + minute) / 60).toInt();
    int weeklyTitleLength = EnumLineChartBottomSideWeeklyTitles.values.length;
    for (int i = 0; i < weeklyTitleLength; i++) {
      bottomTitle.add(BottomSideTitle(
          index: weeklyTotalIndexValue - (remainedTime + ((i) * 24)),
          //24 : reset each 24 hours
          text: EnumLineChartBottomSideWeeklyTitles.getIndexName(
              (passedDayCounter - i) % weeklyTitleLength)));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return "LineChartDataWeekly";
  }

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (rangeTotalIndexValue - diff.inHours).toDouble();
    return diffHours;
  }

/*  void test(int titleLength, int remainedTime,int bottomTotalIndexValue, int resetTime, int passedCompletedTimeCounter){
  for (int i = 0; i < titleLength; i++) {
  bottomTitle.add(BottomSideTitles(
  index: bottomTotalIndexValue - (remainedTime + ((i) * resetTime)),
  // 6 : 60/10, 8 : reset in each 8 hours
  text: EnumLineChartBottomSideDailyTitles.getIndexName(
  (passedCompletedTimeCounter - i) % titleLength)));
  }
  }*/
}
