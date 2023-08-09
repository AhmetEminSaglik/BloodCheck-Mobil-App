import 'package:flutter/material.dart';

import '../../../util/ProductColor.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ProductColor.bodyBackground,
      body: Center(
          child: Text("Patient Profile Body", style: TextStyle(fontSize: 35))),
    );
  }
}
