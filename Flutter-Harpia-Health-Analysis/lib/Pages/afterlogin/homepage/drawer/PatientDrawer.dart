import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/HomePagePatient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/doctor/DoctorProfile.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import '../../../../model/user/Patient.dart';
import '../../../../util/CustomLog.dart';
import '../../../../util/SafeLogoutDrawerItem.dart';
import '../../../../util/SharedPrefUtils.dart';
import '../../profile/patient/PatientProfile.dart';

class PatientDrawer extends StatefulWidget {
  @override
  State<PatientDrawer> createState() => _PatientDrawerState();
  late final int patientId;

  PatientDrawer({required this.patientId});
}

class _PatientDrawerState extends State<PatientDrawer> {
  CustomLog log = CustomLog(className: "PatientDrawer");

  static String name = SharedPrefUtils.getName();
  static String lastname = SharedPrefUtils.getLastname();
  late Patient patient;
  late var pageList;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareAll();
  }

  prepareAll() async {
    await retrievePatient();
    await preparePageList();
  }

  retrievePatient() async {
    patient = await HttpRequestPatient.findPatientById(widget.patientId);
  }

  preparePageList() {
    pageList = [
      HomePagePatient(
          patientId: SharedPrefUtils.getUserId(),
          displayNamePatientPage: "$name $lastname"),
      PatientProfile(patientId: SharedPrefUtils.getUserId()),
      DoctorProfile(doctorId: patient.doctorId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Patient Drawer Header")),
          _buildDrawerListTile(
              context: context, title: "HomePage", selectedIndex: 0),
          _buildDrawerListTile(
              context: context, title: "Profile", selectedIndex: 1),
          _buildDrawerListTile(
              context: context, title: "My Doctor", selectedIndex: 2),
          SafeLogoutDrawerItem(),
        ],
      ),
    );
  }

  ListTile _buildDrawerListTile(
      {required BuildContext context,
      required String title,
      required int selectedIndex}) {
    return ListTile(
      title: Text(title),
      onTap: () {
        context.read<DrawerCubit>().updateBody(pageList[selectedIndex]);
        Navigator.pop(context);
      },
    );
  }
}
