import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPrefUtils.dart';
import '../../../../util/SafeLogoutDrawerItem.dart';
import '../../profile/admin/AdminProfile.dart';
import '../../signuppage/DoctorSignUpPage.dart';
import '../../signuppage/PatientSignUpPage.dart';
import '../users/admin/HomePageAdmin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDrawer extends StatefulWidget {
  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  var pageList = [
    const HomePageAdmin(),
    AdminProfile(adminId: SharedPrefUtils.getUserId()),
    const DoctorSignUpPage(),
    const PatientSignUpPage(),
  ];
  int selectedIndex = 0;

  /*getData() {
    switch(SharedPref.sp.getInt(EnumUserProp.ROLE_ID)){
      case EnumUserRole.ADMIN.roleId:
      case EnumUserRole.DOCTOR.roleId:

    }*/

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Admin Drawer Header")),
          _buildDrawerListTile(
              context: context, title: "HomePage", selectedIndex: 0),
          _buildDrawerListTile(
              context: context, title: "Profile", selectedIndex: 1),
          _buildDrawerListTile(
              context: context, title: "Sign Up Doctor", selectedIndex: 2),
          _buildDrawerListTile(
              context: context, title: "Sign Up Patient", selectedIndex: 3),
          SafeLogoutDrawerItem(),
        ],
      ),
    );
  }

  ListTile _buildDrawerListTile({
    required BuildContext context,
    required String title,
    required int selectedIndex,
  }) {
    return ListTile(
      title: Text(title),
      onTap: () {
        context.read<DrawerCubit>().updateBody(pageList[selectedIndex]);
        if (selectedIndex != 0) {
          context.read<AppBarCubit>().setTitleRoleName();
        }
        Navigator.pop(context);
      },
    );
  }
}
