import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/BaseLineChart.dart';

import '../../../../CustomWidgets/CheckBoxVisibleBloodResultContent.dart';
import '../../../../CustomWidgets/linechart/LineChart6Monthly.dart';
import '../../../../CustomWidgets/linechart/predata/LineChartPreDataMonthly.dart';

class DetailLineChartCubit extends Cubit<BaseLineChart> {
  late BaseLineChart? baseLineChart;

  DetailLineChartCubit()
      : super(LineChart6Monthly(
          baseLineChartPreData: LineChartPreDataMonthly(bloodResultList: []),
          checkBoxVisibleBloodResultContent:
              CheckBoxVisibleBloodResultContent(),
        ));

  void updateBaseLineChart(BaseLineChart baseLineChart) {
    this.baseLineChart = baseLineChart;
    emit(baseLineChart);
  }
}
