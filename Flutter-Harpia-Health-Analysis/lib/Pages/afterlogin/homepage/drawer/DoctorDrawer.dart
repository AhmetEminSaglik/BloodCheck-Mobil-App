import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/DoctorProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/EnumUserProp.dart';
import '../../../../util/SafeLogoutDrawerItem.dart';
import '../../../../util/SharedPref.dart';
import '../appbar/AppBarCubit.dart';
import '../users/HomePageDoctor.dart';

class DoctorDrawer extends StatefulWidget {
  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();

  DoctorDrawer() {
    print("DOCTOR drawer'e geldi");
  }
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  static int doctorId = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;

  var pageList = [HomePageDoctor(doctorId: doctorId), const DoctorProfile()];
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
