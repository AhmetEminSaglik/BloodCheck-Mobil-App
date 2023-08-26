import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/data/BaseLineChartData.dart';

import '../../../../model/LineChartData/BottomSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideMonthlyTitles.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideTitles.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideWeeklyTitles.dart';

class LineChartDataMonthly extends BaseLineChartData {
  LineChartDataMonthly({required super.bloodResultList})
      : super(rangeTotalIndexValue: 180);

  @override
  void createBottomSideTitles() {
    int monthlyTotalIndexValue = 180;
    int day = now.day;
    int hour = now.hour;
    int passedWeekCounter = (day / 7).toInt();
    day %= 7;
    double remainedTime = ((day * 24 + hour) / 24);
    int monthlyTitleLength = EnumLineChartBottomSideMonthlyTitles.values.length;
    for (int i = 0; i <= monthlyTitleLength; i++) {
      bottomTitle.add(BottomSideTitle(
          index: (monthlyTotalIndexValue - (remainedTime + ((i) * 6 * 7)))
              .toInt(), // test each 6 hours and one week is 7 days. ==> 6*7
          text: EnumLineChartBottomSideMonthlyTitles.getIndexName(
              (passedWeekCounter - i) % monthlyTitleLength)));
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return "LineChartDataMonthly";
  }

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (rangeTotalIndexValue - diff.inHours / 4)
        .toDouble(); // each 4 hours, add a new bloodResult Data
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
