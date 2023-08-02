import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/DoctorProfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../util/SafeLogoutDrawerItem.dart';
import '../users/HomePageDoctor.dart';

class DoctorDrawer extends StatefulWidget {
  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();

  DoctorDrawer() {
    print("DOCTOR drawer'e geldi");
  }
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  // static int roleId = SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name) ?? -1;

  var pageList = [const HomePageDoctor(), const DoctorProfile()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("DOCTOR Drawer Header")),
          // DrawerHeader(child: Text("Header")),
          _buildDrawerListTile(
              context: context, title: "HomePage", selectedIndex: 0),
          _buildDrawerListTile(
              context: context, title: "Profile", selectedIndex: 1),
          // _buildDrawerListTileSafeLogout(context: context, title: title, selectedIndex: selectedIndex)
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
