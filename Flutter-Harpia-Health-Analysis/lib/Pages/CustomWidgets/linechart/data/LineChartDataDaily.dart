import '../../../../model/LineChartData/BottomSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideTitles.dart';
import 'BaseLineChartData.dart';

class LineChartPreDataDaily extends BaseLineChartPreData {
  LineChartPreDataDaily({required super.bloodResultList})
      : super(rangeTotalIndexValue: 144);

  @override
  void createBottomSideTitles() {
    int dailyTotalIndexValue = rangeTotalIndexValue;
    int hour = now.hour;
    int minute = now.minute;
    int passed8HoursCounter = (hour / 8).toInt();
    hour %= 8;
    int remainedTime = ((hour * 60 + minute) / 10).toInt();
    int dailyTitleLength = EnumLineChartBottomSideDailyTitles.values.length;

    for (int i = 0; i < dailyTitleLength; i++) {
      bottomTitle.add(BottomSideTitle(
          index: dailyTotalIndexValue - (remainedTime + ((i) * 6 * 8)),
          // 6 : 60/10, 8 : reset in each 8 hours
          text: EnumLineChartBottomSideDailyTitles.getIndexName(
              (passed8HoursCounter - i) % dailyTitleLength)));
    }
  }

  @override
  String toString() {
    return "LineChartPreDataDaily";
  }

/*
  @override
  void setBloodListSubItemsFlSpotValue() {
    bloodListSubItemsFlSpot.bloodResultList.forEach((tmp) {
      bloodListSubItemsFlSpot.bloodSugarList
          .add(getFlSpotOfItem(tmp.bloodSugar, tmp.createdAt));
      bloodListSubItemsFlSpot.bloodPressureList
          .add(getFlSpotOfItem(tmp.bloodPresure, tmp.createdAt));
      bloodListSubItemsFlSpot.magnesiumList
          .add(getFlSpotOfItem(tmp.magnesium, tmp.createdAt));
      bloodListSubItemsFlSpot.calciumList
          .add(getFlSpotOfItem(tmp.calcium, tmp.createdAt));
    });
  }
*/

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffMinutes = rangeTotalIndexValue - diff.inMinutes / 10;
    print("DAILY rangeTotalIndexValue : $rangeTotalIndexValue");
    print("DAILY diffMinutes : $diffMinutes");
    return diffMinutes;
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
