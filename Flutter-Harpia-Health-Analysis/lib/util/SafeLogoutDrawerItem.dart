import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';

class SafeLogoutDrawerItem extends StatefulWidget {
  // const SafeLogOutUtil({required this.context});
  //
  // final BuildContext context;

  @override
  State<SafeLogoutDrawerItem> createState() => _SafeLogoutDrawerItemState();
}

class _SafeLogoutDrawerItemState extends State<SafeLogoutDrawerItem> {
  @override
  Widget build(BuildContext context) {
    return _buildDrawerListTileSafeLogout(context: context);
  }

  ListTile _buildDrawerListTileSafeLogout({required BuildContext context}) {
    return ListTile(
      title: const Text("Safe logout"),
      onTap: () {
        setState(() {
          SafeLogOut.clearSharedPref();
          Navigator.of(context).popUntil(
              (route) => route.isFirst); //removes all pages until first page.
        });
      },
    );
  }
}

class SafeLogOut {
  static void clearSharedPref() {
    SharedPref.sp.clear();
  }
}
