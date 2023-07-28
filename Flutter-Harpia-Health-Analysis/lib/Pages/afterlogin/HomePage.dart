import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';

import 'LineChartDemo2.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.userRoleId});

  final int userRoleId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(EnumUserRole.getRoleName(widget.userRoleId)),
      ),
      body:LineChartDemo2()// MyLineChart(),
    );
  }
}
