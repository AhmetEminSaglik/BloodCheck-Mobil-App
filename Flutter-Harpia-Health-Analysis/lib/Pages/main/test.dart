void main() {
  List<String> dateTextList = [];
  dateTextList.add("2023-08-15 15:19:30.000");
  dateTextList.add("2023-08-15 15:00:30.000");
  dateTextList.add("2023-08-15 14:38:00.000");
  dateTextList.add("2023-08-15 14:18:30.000");
  dateTextList.add("2023-08-15 13:19:30.000");
  dateTextList.add("2023-08-15 12:10:30.000");
  dateTextList.add("2023-08-15 11:19:30.000");
  dateTextList.add("2023-08-15 10:19:30.000");
  dateTextList.add("2023-08-15 10:18:30.000");
  List<DateTime> dateTimeList = [];
  dateTextList.forEach((element) {
    dateTimeList.add(DateTime.parse(element));
  });

  final now = DateTime.now();
  final tmpHour = Duration(hours: 1);

  List<DateTime> selectedDates = [];
  print("now : $now");

  List<List<DateTime>> dateTimeGroupList = [];
  List<DateTime> groupDateTime = [];

  int counterHourMinus = 1;
  var startTime = now;
  var endTime = now.subtract(tmpHour * counterHourMinus);

  for (int i = 0; i < dateTimeList.length; i++) {
    if (dateTimeList[i].isBefore(startTime) &&
            dateTimeList[i].isAfter(endTime) ||
        dateTimeList[i].isAtSameMomentAs(endTime)) {
      groupDateTime.add(dateTimeList[i]);

      if (i == dateTimeList.length - 1) {
        dateTimeGroupList.add(groupDateTime);
      }
    } else {
      i--;
      counterHourMinus++;
      dateTimeGroupList.add(groupDateTime);
      groupDateTime = [];
      startTime = endTime;
      endTime = now.subtract(tmpHour * counterHourMinus);
    }
  }

  print("------------------");
  int counter = 0;
  dateTimeGroupList.forEach((element) {
    counter++;
    print("GROUP : : $counter");
    element.forEach((element) {
      print("$element");
    });
  });
}
