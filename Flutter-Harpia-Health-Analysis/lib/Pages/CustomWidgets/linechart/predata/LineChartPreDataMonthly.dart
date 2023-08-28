import '../../../../model/LineChartData/LineChartSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideMonthlyTitles.dart';
import 'BaseLineChartPreData.dart';

class LineChartPreDataMonthly extends BaseLineChartPreData {
  LineChartPreDataMonthly({required super.bloodResultList})
      : super(rangeTotalIndexValue: 180);

  @override
  void createBottomSideTitles() {
    // print("---->  $rangeTotalIndexValue");
    int monthlyTotalIndexValue = rangeTotalIndexValue;
    double day = now.day.toDouble();
    int hour = now.hour;
    double weekValue = 30 / 4;
    int passedWeekCounter = (day / weekValue).toInt();
    day %= weekValue;
    double remainedTime = ((day * 24 + hour) / 24);
    int monthlyTitleLength = EnumLineChartBottomSideMonthlyTitles.values.length;
    for (int i = 0; i <= monthlyTitleLength; i++) {
      bottomTitle.add(LineChartSideTitle(
          index:
              (monthlyTotalIndexValue - (remainedTime + ((i) * 6 * weekValue)))
                  .toInt(), // test each 6 hours and one week is 7 days. ==> 6*7
          text: EnumLineChartBottomSideMonthlyTitles.getIndexName(
              (passedWeekCounter - i) % monthlyTitleLength)));
    }
  }
/*
  @override
  void createLeftSideTitles() {}*/

  @override
  String toString() {
    // TODO: implement toString
    return "LineChartPreDataMonthly";
  }

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffHours = (rangeTotalIndexValue - diff.inHours / 4)
        .toDouble(); // each 4 hours, add a new bloodResult Data
    print("MONTHLY rangeTotalIndexValue : $rangeTotalIndexValue");
    print("MONTHLY diffHours : $diffHours");

    /*   Duration diff = now.difference(itemCreatedAt);
    double diffHours = (monthlyTotalIndexValue - diff.inHours / 4)
        .toDouble(); // each 4 hours, add a new bloodResult Data
    return diffHours;*/
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
