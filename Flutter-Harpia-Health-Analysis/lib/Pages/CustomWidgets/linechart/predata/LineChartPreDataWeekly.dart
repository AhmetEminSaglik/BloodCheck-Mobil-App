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

  @override
  String toString() {
    // TODO: implement toString
    return "LineChartPreDataWeekly";
  }

/*  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (rangeTotalIndexValue - diff.inHours).toDouble();
    return diffHours;
  }*/
}
