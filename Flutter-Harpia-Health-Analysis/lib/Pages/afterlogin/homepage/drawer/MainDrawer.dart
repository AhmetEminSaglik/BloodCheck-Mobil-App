import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/AdminDrawer.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DoctorDrawer.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/PatientDrawer.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPrefUtils.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  int userRoleId = SharedPrefUtils.getRoleId();

  Widget getUserDrawer() {
    if (userRoleId == EnumUserRole.ADMIN.roleId) {
      return AdminDrawer();
    } else if (userRoleId == EnumUserRole.DOCTOR.roleId) {
      return DoctorDrawer();
    } else if (userRoleId == EnumUserRole.PATIENT.roleId) {
      return PatientDrawer();
    }
    return const Text("Unknow UserRoleType");
  }

  @override
  Widget build(BuildContext context) {
    return getUserDrawer();
  }
}
