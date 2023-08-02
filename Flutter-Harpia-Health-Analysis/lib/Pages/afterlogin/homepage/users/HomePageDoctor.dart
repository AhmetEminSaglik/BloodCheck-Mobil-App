import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import '../../../../model/user/Patient.dart';
import '../listview/patient/PatientListFutureBuilder.dart';

class HomePageDoctor extends StatefulWidget {
  final int id;

  const HomePageDoctor({Key? key, required this.id}) : super(key: key);

  @override
  State<HomePageDoctor> createState() => _HomePageDoctorState();

  Future<List<Patient>> getPatientList(int doctorId) async {
    var http = HttpRequestDoctor();
    List<Patient> patientList = await http.getPatientListOfDoctorId(doctorId);
    return patientList;
  }
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  @override
  Widget build(BuildContext context) {
    return PatientListFutureBuilder(
      patientList: widget.getPatientList(widget.id),
      appBarTitle: "My Patient List (D)",
    );
  }
}
