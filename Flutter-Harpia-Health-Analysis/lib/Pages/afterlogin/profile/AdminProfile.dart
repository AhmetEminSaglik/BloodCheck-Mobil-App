import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProductColor.bodyBackground,
        body: const Center(
            child: Text("Admin Profile Body", style: TextStyle(fontSize: 35))));
  }
}
