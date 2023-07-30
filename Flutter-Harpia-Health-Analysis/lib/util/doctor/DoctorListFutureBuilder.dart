import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/model/user/Patient.dart';
import 'package:flutter_harpia_health_analysis/util/doctor/ListviewBuilderDoctor.dart';
import '../../model/user/Doctor.dart';


class DoctorListFutureBuilder extends StatelessWidget {
  final Future<List<Doctor>> doctorList;
  final String appBarTitle;

  const DoctorListFutureBuilder(
      {super.key, required this.doctorList, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Doctor>>(
      future: doctorList,
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
          List<Doctor> doctorList = snapshot.data ?? [];

          return ListviewBuilderDoctor(
              appBarTitle: appBarTitle,
              doctorList: doctorList);
        }
      },
    );
  }
}
