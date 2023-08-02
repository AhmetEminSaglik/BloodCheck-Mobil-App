import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/HomePagePatient.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/PatientProfile.dart';
import 'package:flutter_harpia_health_analysis/model/EnumUserProp.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../util/SafeLogoutDrawerItem.dart';

class PatientDrawer extends StatefulWidget {
  @override
  State<PatientDrawer> createState() => _PatientDrawerState();

  PatientDrawer() {
    print("Patient drawer'e geldi");
  }
}

class _PatientDrawerState extends State<PatientDrawer> {
  static String name = SharedPref.sp.getString(EnumUserProp.NAME.name);
  static String lastname = SharedPref.sp.getString(EnumUserProp.LASTNAME.name);
  var pageList = [
    HomePagePatient(displayNamePatientPage: "$name $lastname"),
    const PatientProfile()
  ];
  int selectedIndex = 0;

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
