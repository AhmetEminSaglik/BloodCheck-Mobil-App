import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/BaseLineChart.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/patient/DetailLineChartCubit.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/util/AppBarUtil.dart';

class DetailLineChartPage extends StatefulWidget {
  late BaseLineChart baseLineChart;

  DetailLineChartPage({required this.baseLineChart});

  @override
  State<DetailLineChartPage> createState() => _DetailLineChartPageState();
}

class _DetailLineChartPageState extends State<DetailLineChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtil.getAppBar(),
      body: Padding(
        padding:
            EdgeInsets.only(left: ResponsiveDesign.getScreenHeight() / 1000),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<DetailLineChartCubit, BaseLineChart>(
                  builder: (builder, data) {
                widget.baseLineChart = data;
                return Container(
                    /*width: ResponsiveDesign.getScreenWidth() -
                      ResponsiveDesign.getScreenWidth() / 4,
                  height: ResponsiveDesign.getScreenHeight() -
                      ResponsiveDesign.getScreenHeigzht() / 4,*/
                    width: ResponsiveDesign.getCertainWidth(),
                    height: ResponsiveDesign.getCertainHeight() -
                        ResponsiveDesign.getCertainHeight() / 7,
                    child: widget.baseLineChart);
              }),
            ],
          ),
        ),
      ),
    );
  }

  goBackPage() {
    Navigator.pop(context);
  }
}
