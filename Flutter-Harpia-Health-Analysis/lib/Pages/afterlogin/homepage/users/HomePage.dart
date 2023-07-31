import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/HomePagePatient.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/MainAppBar.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/MainDrawer.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';

import '../../../../util/Utils.dart';
import 'HomePageDoctor.dart';
import 'admin/HomePageAdmin.dart';
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();

  HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  int userRoleId = SharedPrefUtils.getRoleId();
  Widget getUserPage() {
    if (userRoleId == EnumUserRole.ADMIN.roleId) {
      return const HomePageAdmin();
    } else if (userRoleId == EnumUserRole.DOCTOR.roleId) {
      return const HomePageDoctor();
    } else if (userRoleId == EnumUserRole.PATIENT.roleId) {
      return const HomePagePatient(displayNamePatientPage: "My Disease Chart");
    }
    return const Text("Unknow UserRoleType is login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:MainAppBar(), // AppBar(title : Text("demo")),
      body: getUserPage(),
      drawer: const MainDrawer(),
    );
  }
}
