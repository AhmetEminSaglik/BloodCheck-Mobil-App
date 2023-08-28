import '../../../../model/LineChartData/LineChartSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideWeeklyTitles.dart';
import 'BaseLineChartPreData.dart';

class LineChartPreDataWeekly extends BaseLineChartPreData {
  LineChartPreDataWeekly({required super.bloodResultList})
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
      bottomTitle.add(LineChartSideTitle(
          index: weeklyTotalIndexValue - (remainedTime + ((i) * 24)),
          //24 : reset each 24 hours
          text: EnumLineChartBottomSideWeeklyTitles.getIndexName(
              (passedDayCounter - i) % weeklyTitleLength)));
    }
  }

/* @override
  void createLeftSideTitles() {
    leftTitle.add(LineChartSideTitle(index: 50, text:" text 50 "));
    leftTitle.add(LineChartSideTitle(index: 100, text:" text 100 "));
    leftTitle.add(LineChartSideTitle(index: 150, text:" text 150 "));

  }*/

  @override
  String toString() {
    // TODO: implement toString
    return "LineChartPreDataWeekly";
  }

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (rangeTotalIndexValue - diff.inHours).toDouble();
    print("WEEKLY rangeTotalIndexValue : $rangeTotalIndexValue");
    print("WEEKLY diffHours : $diffHours");
    return diffHours;
  }

/*  void test(int titleLength, int remainedTime,int bottomTotalIndexValue, int resetTime, int passedCompletedTimeCounter){
  for (int i = 0; i < titleLength; i++) {
  bottomTitle.add(LineChartSideTitles(
  index: bottomTotalIndexValue - (remainedTime + ((i) * resetTime)),
  // 6 : 60/10, 8 : reset in each 8 hours
  text: EnumLineChartBottomSideDailyTitles.getIndexName(
  (passedCompletedTimeCounter - i) % titleLength)));
  }
  }*/
}
