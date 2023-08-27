import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/EnumBloodResultContent.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

import '../../core/ResponsiveDesign.dart';
import 'CheckBoxVisibleBloodResultContent.dart';
import 'delete/CustomLineChartDataDaily.dart';

class LineChartEmpty extends StatefulWidget {

  const LineChartEmpty();

  @override
  State<LineChartEmpty> createState() => _LineChartEmptyState();
}

class _LineChartEmptyState extends State<LineChartEmpty> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(ResponsiveDesign.getScreenHeight() / 100),
        child: Container(
          // color: Colors.red,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.40,
                child: Padding(
                  padding: EdgeInsets.only(
                      right: ResponsiveDesign.getScreenWidth() / 10,
                      top: ResponsiveDesign.getScreenWidth() / 10),
                  child: LineChart(lineChartData()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  LineChartData lineChartData() {
    return LineChartData();
  }

}
