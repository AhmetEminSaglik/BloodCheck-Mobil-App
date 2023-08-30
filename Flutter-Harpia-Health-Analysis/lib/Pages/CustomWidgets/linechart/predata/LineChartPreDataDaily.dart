import '../../../../model/LineChartData/LineChartSideTitle.dart';
import '../../../../model/enums/linechart/bottomtitles/EnumLineChartBottomSideTitles.dart';
import 'BaseLineChartPreData.dart';

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
      bottomTitle.add(LineChartSideTitle(
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

  @override
  double getItemFlSpotXValue({required DateTime itemCreatedAt}) {
    Duration diff = now.difference(itemCreatedAt);
    double diffMinutes = rangeTotalIndexValue - diff.inMinutes / 10;
    return diffMinutes;
  }
}
