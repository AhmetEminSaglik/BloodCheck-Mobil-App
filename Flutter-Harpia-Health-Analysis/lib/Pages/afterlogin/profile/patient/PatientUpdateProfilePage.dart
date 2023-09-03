import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/patient/PatientProfile.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/util/AppBarUtil.dart';
import '../../../../Product/FormCustomInput.dart';
import '../../../../core/ResponsiveDesign.dart';
import '../../../../model/user/Patient.dart';
import '../../../../util/CustomSnackBar.dart';
import '../../../../util/ProductColor.dart';
import '../../../../util/SharedPrefUtils.dart';
import '../ProfilUpdatedCubit.dart';

class PatientUpdateProfilePage extends StatefulWidget {
  late Patient patient;

  PatientUpdateProfilePage({required this.patient});

  @override
  State<PatientUpdateProfilePage> createState() =>
      _PatientUpdateProfilePageState();
}

class _PatientUpdateProfilePageState extends State<PatientUpdateProfilePage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfLastname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtil.getAppBar(),
      backgroundColor: ProductColor.bodyBackground,
      body: Padding(
        padding: EdgeInsets.only(
            left: ResponsiveDesign.getScreenWidth() / 25,
            right: ResponsiveDesign.getScreenWidth() / 25,
            top: ResponsiveDesign.getScreenWidth() / 10,
            bottom: ResponsiveDesign.getScreenWidth() / 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    FormInputTextField(
                      hintText: "Username",
                      controller: tfUsername,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Password",
                      controller: tfPassword,
                      obscure: true,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Name",
                      controller: tfName,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    FormInputTextField(
                      hintText: "Lastname",
                      controller: tfLastname,
                      obscure: false,
                      compulsoryArea: false,
                    ),
                    _UpdateProfileButton(
                      formKey: formKey,
                      defaultPatient: widget.patient,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
                      tfName: tfName,
                      tfLastname: tfLastname,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _UpdateProfileButton extends StatelessWidget {
  late Patient defaultPatient;
  List<TextEditingController> list = [];
  final TextEditingController tfUsername, tfPassword, tfName, tfLastname;
  GlobalKey<FormState> formKey;

  _UpdateProfileButton({
    required this.formKey,
    required this.defaultPatient,
    required this.tfUsername,
    required this.tfPassword,
    required this.tfName,
    required this.tfLastname,
  }) {
    list.add(tfUsername);
    list.add(tfPassword);
    list.add(tfName);
    list.add(tfLastname);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: ElevatedButton(
            onPressed: () {
              _updateProfileProcess(context);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.pink),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white)),
            child: Text("Update Profile",
                style: TextStyle(
                    fontSize: ResponsiveDesign.getScreenWidth() / 20))));
  }

  void resetTextFields(List<TextEditingController> list) {
    list.forEach((e) => e.text = "");
  }

  bool isAnyAreaFilled() {
    if (tfUsername.text.isNotEmpty ||
        tfPassword.text.isNotEmpty ||
        tfName.text.isNotEmpty ||
        tfLastname.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void _updateProfileProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      if (isAnyAreaFilled()) {
        String username = tfUsername.text;
        String password = tfPassword.text;
        String name = tfName.text;
        String lastname = tfLastname.text;

        Patient doctor = Patient(
          id: defaultPatient.id,
          roleId: defaultPatient.roleId,
          name: name.isNotEmpty ? name : defaultPatient.name,
          lastname: lastname.isNotEmpty ? lastname : defaultPatient.lastname,
          username: username.isNotEmpty ? username : defaultPatient.username,
          password: password.isNotEmpty ? password : defaultPatient.password,
          diabeticTypeId: defaultPatient.diabeticTypeId,
          doctorId: defaultPatient.doctorId,
        );
        var request = HttpRequestPatient();

        ResponseEntity? respEntity;

        await request.update(doctor).then((value) => respEntity = value);

        if (respEntity != null) {
          if (respEntity!.success) {
            context.read<ProfilUpdatedCubit>().setTrue();
            await SharedPrefUtils.setLoginDataUser(doctor).then((value) {});
            Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PatientProfile(patientId: defaultPatient.id)));
            String msg = "Updated Successfuly";
            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar.getSnackBar(msg));

          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(CustomSnackBar.getSnackBar(respEntity!.message));
          }
        }
      } else {
        String msg = "Must be filled at least one area to update profile";
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.getSnackBar(msg));
      }
    }
  }
}
