import 'dart:math';

void main() {
  // testDateTime();
  // testDoubleNumber();
  // testModeNegative();
  // testDoubleToIntNumbers();
  // testDoubleToInt2();
  testMathMinMax();
}

void testMathMinMax(){
  print([1,2,8,6].reduce(max)); // 8
  print([1,2,8,6].reduce(min)); // 1

}

void testDoubleToInt2() {
  double num1 = 1.4;
  double num2 = 1;
  double num3 = 1.9;

  print(num1.toInt());
  print(num2.toInt());
  print(num3.toInt());
}

void testDoubleToIntNumbers() {
  double num1 = 1.4;
  double num2 = 1.5;

  print(num1.round());
  print(num2.round());
}

void testModeNegative() {
  int val = -1;
  print("Value :$val");
  print("mod 4 : ${val % 4}");
}

void testDoubleNumber() {
  double value1 = 2.11;
  double value2 = 5.99;

  double result1 = max(value1, 2);
  double result2 = max(value2, 5);

  print("${value1}  : ${value1.toInt()}");
  print("${value2}  : ${value2.toInt()}");
/*
  print("${value1}  : ${value1.toDouble()}");
  print("${value2}  : ${value2.toDouble()}");

  print("${value1}  : ${value1.ceilToDouble()}");
  print("${value2}  : ${value2.ceilToDouble()}");

  print("${value1}  : ${value1.ceil()}");
  print("${value2}  : ${value2.ceil()}");

  print("${value1}  : ${value1.floor()}");
  print("${value2}  : ${value2.floor()}");

  print("${value1}  : ${value1.truncate()}");
  print("${value2}  : ${value2.truncate()}");*/
}

void testDateTime() {
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
