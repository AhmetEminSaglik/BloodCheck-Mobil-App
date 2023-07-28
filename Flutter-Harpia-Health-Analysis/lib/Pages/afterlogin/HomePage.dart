import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/DiseaseChartWidget.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDisease.dart';
import 'package:flutter_harpia_health_analysis/model/EnumUserProp.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/Disease.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/DiseaseFactory.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';

import '../CustomWidgets/LineChartDemo1.dart';
import '../CustomWidgets/LineChartDemo2.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: 700, height: 300, child: DiseaseChartWidget()),
            SizedBox(width: 450, height: 300, child: LineChartDemo1()),
            SizedBox(width: 450, height: 300, child: LineChartDemo2()),
            // LineChartDemo2(),
          ],
        ),
      )
      /*SingleChildScrollView(
        child: Column(
          children: [
            // LineChartDemo2()
            ElevatedButton(
              child: Text("Test"),
              onPressed: () {
                // printDiseaseData();
              },
            ),
          ],
        ),
      )*/
      ,
    ); // MyLineChart(),'
  }
}

Future<List<Disease>> getDiseaseData() async {
  var http = HttpRequestDisease();
  // print('patient Id :');
  var patientId = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;
  print('patient Id : $patientId');
  // List<Disease> list = [];
  List<Disease> list = await http
      .getDiseaseListOfPatientid(patientId); //.then((value) => {list = value}
  // list.forEach((e) {
  //   print("disease : $e");
  // });
  return list;
}
