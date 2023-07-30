import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/DiseaseChartWidget.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePageAdmin.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePageDoctor.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePagePatient.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDisease.dart';
import 'package:flutter_harpia_health_analysis/model/EnumUserProp.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/Disease.dart';
import 'package:flutter_harpia_health_analysis/business/factory/DiseaseFactory.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';

import '../../CustomWidgets/LineChartDemo1.dart';
import '../../CustomWidgets/LineChartDemo2.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.userRoleId});

  final int userRoleId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getContentPage() {
    if (widget.userRoleId == EnumUserRole.ADMIN.roleId) {
      return const HomePageAdmin();
    } else if (widget.userRoleId == EnumUserRole.DOCTOR.roleId) {
      return const HomePageDoctor();
    } else if (widget.userRoleId == EnumUserRole.PATIENT.roleId) {
      return const HomePagePatient();
    }
    return const Text("Unknow UserRoleType is login");
  }

  @override
  Widget build(BuildContext context) {
    return getContentPage(); // MyLineChart(),'
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
