import 'package:flutter/material.dart';

import '../../../util/ProductColor.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: const Center(
          child: Text("Doctor Profile Body", style: TextStyle(fontSize: 35))),
    );
  }
}
