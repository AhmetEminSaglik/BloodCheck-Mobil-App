import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/listview/patient/ListviewBuilderPatient.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/util/PermissionUtils.dart';
import '../../../../model/user/Patient.dart';
import '../../../../util/ProductColor.dart';
import '../appbar/AppBarCubit.dart';

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
  bool visibleAppBar = false;

  @override
  void initState() {
    super.initState();
    visibleAppBar = PermissionUtils.letRunForAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: visibleAppBar ? getAppBar() : null,
      body: ListviewBuilderPatient(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: ProductColor.appBarBackgroundColor,
      title: BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
        return titleWidget;
      }),
    );
  }
}
