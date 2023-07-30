import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/admin/HomePageAdmin.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePageDoctor.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePagePatient.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
class HomePage extends StatefulWidget {
  const HomePage({required this.userRoleId});

  final int userRoleId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getUserPage() {
    if (widget.userRoleId == EnumUserRole.ADMIN.roleId) {
      return const HomePageAdmin();
    } else if (widget.userRoleId == EnumUserRole.DOCTOR.roleId) {
      return const HomePageDoctor();
    } else if (widget.userRoleId == EnumUserRole.PATIENT.roleId) {
      return const HomePagePatient(displayNamePatientPage: "My Disease Chart");
    }
    return const Text("Unknow UserRoleType is login");
  }

  @override
  Widget build(BuildContext context) {
    return getUserPage();
  }
}
