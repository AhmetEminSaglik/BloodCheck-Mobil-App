import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/BaseLineChart.dart';

import '../../../core/ResponsiveDesign.dart';

class LineChartWeekly extends BaseLineChart {
  double rangeIndex = 168;

  LineChartWeekly(
      {required super.baseLineChartPreData,
      required super.checkBoxVisibleBloodResultContent,
      double aspectRadio = 1.40})
      : super(aspectRadio: aspectRadio);

  @override
  LineChartData getLineChartData() {
    return LineChartData(
        borderData: FlBorderData(border: Border.all(color: Colors.white)),
        minX: -1,
        maxX: rangeIndex,
        minY: -1,
        maxY: 200,
        gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return value == 0
                  ? const FlLine(color: Colors.black, strokeWidth: 3)
                  : const FlLine(strokeWidth: 0);
            },
            getDrawingVerticalLine: (value) {
              return value == 0
                  ? const FlLine(color: Colors.black, strokeWidth: 3)
                  : const FlLine(strokeWidth: 0);
            }),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
                reservedSize: ResponsiveDesign.getScreenWidth() / 10,
                showTitles: true,
                interval: 1,
                getTitlesWidget: leftTiles),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                reservedSize: ResponsiveDesign.getScreenHeight() / 40,
                interval: 1,
                showTitles: true,
                getTitlesWidget: bottomTiles),
          ),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineBarsData: [
          isVisibleBloodSugar
              ? getBloodSugarLineChartBarData()
              : LineChartBarData(),
          isVisibleBloodPressure
              ? getBloodPressureLineChartBarData()
              : LineChartBarData(),
          isVisibleCalcium ? getCalciumLineChartBarData() : LineChartBarData(),
          isVisibleMagnesium
              ? getMagnesiumLineChartBarData()
              : LineChartBarData(),
        ]);
  }
}
