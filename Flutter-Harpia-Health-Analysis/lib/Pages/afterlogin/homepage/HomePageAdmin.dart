import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/util/doctor/DoctorListFutureBuilder.dart';
import '../../../model/user/Doctor.dart';
import '../../../model/user/Patient.dart';
import '../../../util/patient/PatientListFutureBuilder.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  @override
  Widget build(BuildContext context) {
    // return DoctorListFutureBuilder(doctorList: getDoctorList(), appBarTitle: "Doctor List");\
    return DoctorListFutureBuilder(
        doctorList: getDoctorList(), appBarTitle: "Doctor List");
    /*return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: DoctorListFutureBuilder(
                  doctorList: getDoctorList(), appBarTitle: "Doctor List"),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            height: 200,
            child: PatientListFutureBuilder(
              patientList: getPatientList(),
              appBarTitle: "Patient List",
            ),
          )
        ],
      ),
    );*/
  }
}

Future<List<Patient>> getPatientList() async {
  var http = HttpRequestPatient();
  List<Patient> patientList = await http.getPatientList();
  print('patient list size : ${patientList.length}');
  return patientList;
}

Future<List<Doctor>> getDoctorList() async {
  var http = HttpRequestDoctor();
  List<Doctor> doctorList = await http.getDoctorList();
  print('doctorList  size : ${doctorList.length}');
  return doctorList;
}
