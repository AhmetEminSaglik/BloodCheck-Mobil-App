import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartDemo1.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';

import '../../CustomWidgets/LineChartDemo2.dart';

class HomePagePatientContent extends StatefulWidget {
  const HomePagePatientContent({Key? key}) : super(key: key);

  @override
  State<HomePagePatientContent> createState() => _HomePagePatientContentState();
}

class _HomePagePatientContentState extends State<HomePagePatientContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 450, height: 300, child: LineChartDemo1()),
        SizedBox(width: 450, height: 300, child: LineChartDemo2()),
      ],
    );
  }
}
