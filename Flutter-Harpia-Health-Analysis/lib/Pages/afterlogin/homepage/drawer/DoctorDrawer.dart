import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/doctor/DoctorProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPrefUtils.dart';
import 'package:logger/logger.dart';
import '../../../../util/SafeLogoutDrawerItem.dart';
import '../appbar/AppBarCubit.dart';
import '../users/HomePageDoctor.dart';

class DoctorDrawer extends StatefulWidget {
  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  late int doctorId = SharedPrefUtils.getUserId();
  static var log = Logger(printer: PrettyPrinter(colors: false));

  @override
  void initState() {
    super.initState();
  }

  late var pageList = [
    HomePageDoctor(doctorId: doctorId),
    DoctorProfile(doctorId: doctorId)
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("DOCTOR Drawer Header")),
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
        context.read<AppBarCubit>().setTitleRoleName();
        Navigator.pop(context);
      },
    );
  }
/*
  ListTile _buildDrawerListTileSafeLogout({
    required BuildContext context,
    required String title,
    required int selectedIndex,
  }) {
    return ListTile(
      title: Text(title),
      onTap: () {
        setState(() {
          Navigator.of(context).popUntil(
              (route) => route.isFirst); //removes all pages until first page.
        });
      },
    );
  }*/
}
