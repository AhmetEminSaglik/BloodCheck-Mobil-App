import 'package:flutter/material.dart';

import '../../../../../httprequest/HttpRequestDoctor.dart';
import '../../../../../model/user/Doctor.dart';
import 'ListviewBuilderDoctor.dart';

class DoctorListFutureBuilder extends StatefulWidget {
  @override
  State<DoctorListFutureBuilder> createState() =>
      _DoctorListFutureBuilderState();
}

class _DoctorListFutureBuilderState extends State<DoctorListFutureBuilder> {
  bool isLoading = true;
  List<Doctor> docList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    print("CALISTI");
    isLoading = true;
    setState(() {});
    var resp = await HttpRequestDoctor.getDoctorList();
    setState(() {
      isLoading = false;
      docList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListviewBuilderDoctor(doctorList: docList);
    /*  return FutureBuilder<List<Doctor>>(
      future: getData(),
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

          return ListviewBuilderDoctor(doctorList: doctorList);
        }
      },
    );*/
  }
}
