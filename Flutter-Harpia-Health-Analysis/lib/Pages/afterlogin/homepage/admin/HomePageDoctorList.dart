import 'package:flutter/material.dart';

import '../../../../httprequest/HttpRequestDoctor.dart';
import '../../../../model/user/Doctor.dart';
import '../../../../util/doctor/DoctorListFutureBuilder.dart';

class HomePageDoctorList extends StatelessWidget {
  const HomePageDoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DoctorListFutureBuilder(
        doctorList: getDoctorList(), appBarTitle: "Doctor List");
  }
}

Future<List<Doctor>> getDoctorList() async {
  var http = HttpRequestDoctor();
  List<Doctor> doctorList = await http.getDoctorList();
  print('doctorList  size : ${doctorList.length}');
  return doctorList;
}
