import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartDemo1.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import '../../../../httprequest/HttpRequestDisease.dart';
import '../../../../model/EnumUserProp.dart';
import '../../../../model/diesease/Disease.dart';
import '../../../../util/SharedPref.dart';
import '../../../CustomWidgets/LineChartDemo2.dart';

class HomePagePatient extends StatefulWidget {
  final String displayNamePatientPage;

  const HomePagePatient({super.key, required this.displayNamePatientPage});

  @override
  State<HomePagePatient> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printDiseaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 450, height: 300, child: LineChartDemo1()),
            SizedBox(width: 450, height: 300, child: LineChartDemo2()),
          ],
        ),
      ),
    );
  }
}

Future<void> printDiseaseList() async {
  var http = HttpRequestDisease();
  // print('patient Id :');
  if ((SharedPref.sp.getInt(EnumUserProp.ID.name) ??
      -1) == EnumUserRole.PATIENT) {
    var patientId = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;
    print('patient Id : $patientId');

    List<Disease> list = await http
        .getDiseaseListOfPatientid(patientId); //.then((value) => {list = value}
    list.forEach((e) {
      print("disease : $e");
    });
  }
}
