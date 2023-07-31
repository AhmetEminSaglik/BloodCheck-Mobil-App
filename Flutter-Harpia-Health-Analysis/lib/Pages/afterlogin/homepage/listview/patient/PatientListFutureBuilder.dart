import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/model/user/Patient.dart';
import 'ListviewBuilderPatient.dart';

class PatientListFutureBuilder extends StatelessWidget {
  final Future<List<Patient>> patientList;
  final String appBarTitle;

  const PatientListFutureBuilder(
      {super.key, required this.patientList, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Patient>>(
      future: patientList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('ERROR: ${snapshot.error}'),
          );
        } else {
          List<Patient> patientList = snapshot.data ?? [];

          return ListviewBuilderPatient(
              // routePage: const HomePagePatient(displayNamePatientPage: patientList[inde]),
              patientList: patientList);
        }
      },
    );
  }
}
