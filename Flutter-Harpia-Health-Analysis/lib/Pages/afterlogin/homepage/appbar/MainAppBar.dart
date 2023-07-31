import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarAdmin.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarDoctor.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarPatient.dart';

import '../../../../model/userrole/EnumUserRole.dart';
import '../../../../util/Utils.dart';


class MainAppBar extends AppBar {
  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  final int _userRoleId = SharedPrefUtils.getRoleId();

  AppBar getUserAppBar() {
    if (_userRoleId == EnumUserRole.ADMIN.roleId) {
      return AppBarAdmin();
    } else if (_userRoleId == EnumUserRole.DOCTOR.roleId) {
      return AppBarDoctor();
    } else if (_userRoleId == EnumUserRole.PATIENT.roleId) {
      return AppBarPatient();
    }
    return AppBar(
      title: Text("Unknow UserRoleType is login"),
    ); //const Text("Unknow UserRoleType is login");
  }

  @override
  Widget build(BuildContext context) {
    return getUserAppBar();
  }
}

/*
class MainAppBar extends AppBar {
  MainAppBar({super.key});

  // static int _userRoleId = SharedPrefUtils.getRoleId();
  int _userRoleId = SharedPrefUtils.getRoleId();

   AppBar getUserAppBar() {
    if (_userRoleId == EnumUserRole.ADMIN.roleId) {
      return AppBarAdmin();
    } else if (_userRoleId == EnumUserRole.DOCTOR.roleId) {
      return AppBarDoctor();
    } else if (_userRoleId == EnumUserRole.PATIENT.roleId) {
      return AppBarPatient();
    }
    return AppBar(
      title: Text("Unknow UserRoleType is login"),
    ); //const Text("Unknow UserRoleType is login");
  }
}
*/
