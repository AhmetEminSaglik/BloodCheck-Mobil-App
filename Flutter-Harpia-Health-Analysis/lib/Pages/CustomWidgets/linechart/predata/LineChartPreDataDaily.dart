import '../../../../model/LineChartData/LineChartSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideTitles.dart';
import 'BaseLineChartPreData.dart';

class LineChartPreDataDaily extends BaseLineChartPreData {
  int divideMinutesFasterProcess=10;
  LineChartPreDataDaily({required super.bloodResultList})
      : super(rangeTotalIndexValue: 24*6); // 24 hours, to calculate faster, minutes are added 1/10 like 60 minutes -> 6 minues

  @override
  void createBottomSideTitles() {
    int dailyTotalIndexValue = rangeTotalIndexValue;
    int hour = now.hour;
    int minute = now.minute;
    int passed8HoursCounter = hour ~/ 8;
    hour %= 8;
    // int remainedTime = ((hour * 60 + minute) / 20).toInt();
    double remainedTime = (hour * 6 + minute/divideMinutesFasterProcess).toDouble();
    int dailyTitleLength = EnumLineChartBottomSideDailyTitles.values.length;
    for (int i = 0; i < dailyTitleLength; i++) {
      bottomTitle.add(LineChartSideTitle(
          index: dailyTotalIndexValue - (remainedTime + ((i) * 6 * 8)).toInt(),
          // 6 : 60/10, 8 : reset in each 8 hours
          text: EnumLineChartBottomSideDailyTitles.getIndexName(
              (passed8HoursCounter - i) % dailyTitleLength)));
    }
  }

  @override
  String toString() {
    return "LineChartPreDataDaily";
  }
static int counter=0;
  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    print("Counter ${++counter/4}");
    Duration diff = now.difference(itemCreatedAt);
    double diffMinutes = rangeTotalIndexValue - diff.inMinutes /divideMinutesFasterProcess; // minutes used as 1 digit instead of 2 digit. For example 60 minutes -> 6
    print("Daily : $diffMinutes}");
    return diffMinutes;
  }
}
