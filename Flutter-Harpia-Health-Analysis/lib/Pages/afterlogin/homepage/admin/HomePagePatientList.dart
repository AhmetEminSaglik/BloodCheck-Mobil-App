import 'package:flutter/material.dart';
import '../../../../httprequest/HttpRequestPatient.dart';
import '../../../../model/user/Patient.dart';
import '../listview/patient/PatientListFutureBuilder.dart';

class HomePagePatientList extends StatelessWidget {
  const HomePagePatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PatientListFutureBuilder(patientList: getPatientList(), appBarTitle: "Patient List");
  }
}

Future<List<Patient>> getPatientList() async {
  var http = HttpRequestPatient();
  List<Patient> patientList = await http.getPatientList();
  print('patient list size : ${patientList.length}');
  return patientList;
}