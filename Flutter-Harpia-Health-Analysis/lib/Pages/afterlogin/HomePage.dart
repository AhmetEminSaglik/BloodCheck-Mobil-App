import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.userRoleId});

  final int userRoleId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(EnumUserRole.getRoleName(widget.userRoleId)),
      ),
      body: MyLineChart(),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text("Test 1"),
          Text("Test2 "),
          Text("Test3"),
          Text("Test 4"),
        ],
      ),
    );
  }
}

TextStyle axisTextStyle() {
  return TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red);
}

Widget bottomTiles(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 2:
      text = '20';
      break;
    case 4:
      text = '40';
      break;
    case 6:
      text = '60';
      break;
    case 8:
      text = '80';
      break;
    default:
      return Text("");
  }
  return Text(
    text,
    style: axisTextStyle(),
    textAlign: TextAlign.left,
  );
}

Widget leftTiles(double value, TitleMeta meta) {
  String text;
  switch (value.toInt()) {
    case 2:
      text = '50 mg';
      break;
    case 5:
      text = '100 mg';
      break;
    case 9:
      text = '150 mg';
      break;
    default:
      return Text("");
  }
  return Text(
    text,
    style: axisTextStyle(),
    textAlign: TextAlign.left,
  );
}

class MyLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 10,
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
              // axisNameWidget: CustomWidget(),
              sideTitles: SideTitles(
                  reservedSize: 110,
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: leftTiles),
            ),
            bottomTitles: AxisTitles(
              axisNameSize: 25,
              // axisNameWidget: CustomWidget(),
              sideTitles: SideTitles(
                  reservedSize: 50,
                  showTitles: true,
                  getTitlesWidget: bottomTiles),
            ),
            /*leftTitles: SideTitles(showTitles: true),
        bottomTitles: SideTitles(showTitles: true),*/
          ),
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(color: Colors.green, strokeWidth: 1);
              },
              getDrawingVerticalLine: (value) {
                return FlLine(color: Colors.black, strokeWidth: 1);
              }),
          borderData: FlBorderData(
              show: true, border: Border.all(color: Colors.red, width: 3)),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(1, 6),
                const FlSpot(2, 4),
                const FlSpot(3, 8),
                const FlSpot(4, 6),
                const FlSpot(5, 7),
                const FlSpot(6, 6.5),
              ],
              isCurved: true,
              color: Colors.blue,
              barWidth: 5,
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.5)),
            )
          ],
        ),
      );
}
