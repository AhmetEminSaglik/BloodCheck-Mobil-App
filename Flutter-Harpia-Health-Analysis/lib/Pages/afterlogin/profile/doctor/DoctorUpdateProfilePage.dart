import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/util/AppBarUtil.dart';

import '../../../../util/ProductColor.dart';
import '../../homepage/appbar/AppBarCubit.dart';

class DoctorUpdateProfilePage extends StatefulWidget {
  const DoctorUpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<DoctorUpdateProfilePage> createState() =>
      _DoctorUpdateProfilePageState();
}

class _DoctorUpdateProfilePageState extends State<DoctorUpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtil.getAppBar(),
      body: const Text("PROFIL UPDATE PAGE"),
    );
  }

}
