import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePageDoctor.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/admin/HomePageAdmin.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/AdminProfile.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/AdminProfile.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/DoctorProfile.dart';

import '../../../../util/SafeLogoutDrawerItem.dart';

class PatientDrawer extends StatefulWidget {
  @override
  State<PatientDrawer> createState() => _PatientDrawerState();
  PatientDrawer() {
    print("Patient drawer'e geldi");
  }
}

class _PatientDrawerState extends State<PatientDrawer> {
  // static int roleId = SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name) ?? -1;

  var pageList = [/*const HomePageDoctor(),*/ const DoctorProfile()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Patient Drawer Header")),
          // DrawerHeader(child: Text("Header")),
          _buildDrawerListTile(
              context: context, title: "HomePage", selectedIndex: 0),
          _buildDrawerListTile(
              context: context, title: "Profile", selectedIndex: 1),
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
        setState(() {
          selectedIndex = selectedIndex;
          Navigator.pop(context);
        });
      },
    );
  }
}
