import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/src/chart/line_chart/line_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/BaseLineChart.dart';

import '../../../core/ResponsiveDesign.dart';

class LineChartDaily extends BaseLineChart {
  double rangeIndex = 144;

  LineChartDaily(
      {required super.baseLineChartPreData,
      required super.checkBoxVisibleBloodResultContent,
      double aspectRadio = 1.40})
      : super(aspectRadio: aspectRadio);

  @override
  LineChartData getLineChartData() {
    showFlDotData = true;
    return LineChartData(
        borderData: FlBorderData(border: Border.all(color: Colors.white)),
        minX: -1,
        maxX: rangeIndex,
        minY: -1,//baseLineChartPreData.lineChartMinY,
        maxY: baseLineChartPreData.lineChartMaxY.toDouble()+1,
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
                getTitlesWidget: getLeftSideTiles),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                reservedSize: ResponsiveDesign.getScreenHeight() / 40,
                interval: 1,
                showTitles: true,
                getTitlesWidget: getBottomSideTiles),
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
