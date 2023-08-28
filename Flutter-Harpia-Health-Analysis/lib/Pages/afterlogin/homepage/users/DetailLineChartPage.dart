import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/BaseLineChart.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import '../../../../util/ProductColor.dart';
import '../appbar/AppBarCubit.dart';

class DetailLineChartPage extends StatelessWidget {
  late final BaseLineChart baseLineChart;

  DetailLineChartPage({required this.baseLineChart}); // bool visibleAppBar =
  //     PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Padding(
        padding:
            EdgeInsets.only(left: ResponsiveDesign.getScreenHeight() / 1000),
        child: SingleChildScrollView(
          child: Container(
              /*width: ResponsiveDesign.getScreenWidth() -
                  ResponsiveDesign.getScreenWidth() / 4,
              height: ResponsiveDesign.getScreenHeight() -
                  ResponsiveDesign.getScreenHeight() / 4,*/
              width: ResponsiveDesign.getCertainWidth(),
              height: ResponsiveDesign.getCertainHeight() -
                  ResponsiveDesign.getCertainHeight() / 7,
              child: baseLineChart),
        ),
      ),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: ProductColor.appBarBackgroundColor,
      title: BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
        return titleWidget;
      }),
    );
  }
}
