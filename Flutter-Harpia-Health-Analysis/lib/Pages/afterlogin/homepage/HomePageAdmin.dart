import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import '../../../model/user/Patient.dart';
import '../../../util/PatientListFutureBuilder.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  @override
  Widget build(BuildContext context) {
    return PatientListFutureBuilder(
      patientList: getPatientList(),
      appBarTitle: "Patient List",
    );
  }
}

Future<List<Patient>> getPatientList() async {
  var http = HttpRequestPatient();
  List<Patient> patientList = await http.getPatientList();
  return patientList;
}
