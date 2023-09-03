import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_harpia_health_analysis/util/AppBarUtil.dart';
import '../../../../Product/FormCustomInput.dart';
import '../../../../business/factory/UserFactory.dart';
import '../../../../core/ResponsiveDesign.dart';
import '../../../../httprequest/HttpRequestDoctor.dart';
import '../../../../httprequest/ResponseEntity.dart';
import '../../../../model/user/Doctor.dart';
import '../../../../model/user/User.dart';
import '../../../../model/userrole/EnumUserRole.dart';
import '../../../../util/CustomAlertDialog.dart';
import '../../../../util/ProductColor.dart';
import 'dart:convert';

class DoctorUpdateProfilePage2 extends StatefulWidget {
  const DoctorUpdateProfilePage2({Key? key}) : super(key: key);

  @override
  State<DoctorUpdateProfilePage2> createState() =>
      _DoctorUpdateProfilePage2State();
}

class _DoctorUpdateProfilePage2State extends State<DoctorUpdateProfilePage2> {
  var formKey = GlobalKey<FormState>();
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfLastname = TextEditingController();
  TextEditingController tfSpecialization = TextEditingController();
  TextEditingController tfGraduate = TextEditingController();

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
              Text("update profil Page 2 "),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    FormInputTextField(
                        hintText: "Username",
                        controller: tfUsername,
                        obscure: false),
                    FormInputTextField(
                        hintText: "Password",
                        controller: tfPassword,
                        obscure: true),
                    FormInputTextField(
                        hintText: "Name", controller: tfName, obscure: false),
                    FormInputTextField(
                        hintText: "Lastname",
                        controller: tfLastname,
                        obscure: false),
                    FormInputTextField(
                        hintText: "Spelization",
                        controller: tfSpecialization,
                        obscure: false),
                    FormInputTextField(
                        hintText: "Graduate",
                        controller: tfGraduate,
                        obscure: false),
                    _UpdateProfileButton(
                      formKey: formKey,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
                      tfName: tfName,
                      tfLastname: tfLastname,
                      tfGraduate: tfGraduate,
                      tfSpecialization: tfSpecialization,
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
  List<TextEditingController> list = [];

  final TextEditingController tfUsername,
      tfPassword,
      tfName,
      tfLastname,
      tfSpecialization,
      tfGraduate;
  GlobalKey<FormState> formKey;

  _UpdateProfileButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname,
      required this.tfGraduate,
      required this.tfSpecialization}) {
    list.add(tfUsername);
    list.add(tfPassword);
    list.add(tfName);
    list.add(tfLastname);
    list.add(tfGraduate);
    list.add(tfSpecialization);
  } //({super.key /*,required this.screenInfo*/});

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

  void _updateProfileProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      String name = tfName.text;
      String lastname = tfLastname.text;
      String specialization = tfSpecialization.text;
      String graduate = tfGraduate.text;
      var request = HttpRequestDoctor();
      Doctor doctor = Doctor(
        id: 0,
        roleId: EnumUserRole.DOCTOR.roleId,
        name: name,
        lastname: lastname,
        username: username,
        password: pass,
        specialization: specialization,
        graduate: graduate,
      );
      request.signUp(doctor).then((resp) async {
        Map<String, dynamic> jsonData = json.decode(resp.body);

        var respEntity = ResponseEntity.fromJson(jsonData);
        if (!respEntity.success) {
          showAlertDialogInvalidUsername(
              context: context, msg: respEntity.message);
        } else {
          User user = UserFactory.createUser(respEntity.data);
          showAlertDialogDoctorSignUpSuccessfully(
              context: context, msg: respEntity.message);
          List<TextEditingController> list = [
            tfUsername,
            tfPassword,
            tfName,
            tfLastname
          ];
          resetTextFields(list);
        }
      });
    }
  }

  void showAlertDialogInvalidUsername(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogUserSignUp(
            success: false,
            context: context,
            title: "Sign-Up",
            subTitle: "Failed :",
            msg: msg,
            roleId: EnumUserRole.DOCTOR.roleId));
  }

  void showAlertDialogDoctorSignUpSuccessfully(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogUserSignUp(
            success: true,
            context: context,
            title: "Sign-Up",
            subTitle: "Successfull",
            msg: msg,
            roleId: EnumUserRole.DOCTOR.roleId));
  }
}
