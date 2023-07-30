import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';
import '../../../model/EnumUserProp.dart';
import '../../../model/user/Patient.dart';
import '../../../util/patient/PatientListFutureBuilder.dart';

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({Key? key}) : super(key: key);

  @override
  State<HomePageDoctor> createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  @override
  Widget build(BuildContext context) {
    return PatientListFutureBuilder(
    patientList: getPatientList(), appBarTitle:  "My Patient List",
    );
  }
}

Future<List<Patient>> getPatientList() async {
  int id = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;
  var http = HttpRequestDoctor();
  List<Patient> patientList = await http.getPatientListOfDoctorId(id);
  return patientList;
}
