import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPrefUtils.dart';

class SafeLogoutDrawerItem extends StatefulWidget {
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
      title: const Text("Safe Logout"),
      onTap: () {
        setState(() {
          SafeLogOut.clearSharedPref();
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      },
    );
  }
}

class SafeLogOut {
  static void clearSharedPref() {
    SharedPrefUtils.sp.clear();
  }
}
