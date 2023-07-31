import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/admin/HomePageAdmin.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/AdminProfile.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/AdminProfile.dart';

import '../../../../util/SafeLogoutDrawerItem.dart';

class AdminDrawer extends StatefulWidget {
  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  // static int roleId = SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name) ?? -1;
  var pageList = [const HomePageAdmin(), const AdminProfile()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text("Admin Drawer Header")),
          // DrawerHeader(child: Text("Header")),
          _buildDrawerListTile(
              context: context, title: "HomePage", selectedIndex: 0),
          _buildDrawerListTile(
              context: context, title: "Profile", selectedIndex: 1),
          // _buildDrawerListTileSafeLogout(context:  context,title: "Safe logout",selectedIndex: 3)
          SafeLogoutDrawerItem(),
        ],
      ),
    );
  }

/*  ListTile _buildDrawerListTileSafeLogout({
    required BuildContext context,
    required String title,
    required int selectedIndex,
  }) {
    return ListTile(
          title: Text(title),
          onTap: () {
            setState(() {
              Navigator.of(context).popUntil((route) => route.isFirst); //removes all pages until first page.
            });
          },
        );
  }*/

  ListTile _buildDrawerListTile({
    required BuildContext context,
    required String title,
    required int selectedIndex,
  }) {
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
