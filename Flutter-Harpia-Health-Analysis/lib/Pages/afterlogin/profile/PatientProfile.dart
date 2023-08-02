import 'package:flutter/material.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Patient Profile Body",style: TextStyle(fontSize: 35),)),
    );
  }
}
