import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';

import '../../../business/factory/UserFactory.dart';
import '../../../core/ResponsiveDesign.dart';
import '../../../httprequest/HttpRequestUser.dart';
import '../../../httprequest/ResponseEntity.dart';
import '../../../model/user/User.dart';
import '../../../util/CustomSnackBar.dart';
import '../../../util/ProductColor.dart';
import 'dart:convert';

class DoctorRegisterPage extends StatefulWidget {
  const DoctorRegisterPage({Key? key}) : super(key: key);

  @override
  State<DoctorRegisterPage> createState() => _DoctorRegisterPageState();
}

class _DoctorRegisterPageState extends State<DoctorRegisterPage> {
  var formKey = GlobalKey<FormState>();
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfLastname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _FormInputTextField(
                        hintText: "Username",
                        controller: tfUsername,
                        obscure: false),
                    _FormInputTextField(
                        hintText: "Password",
                        controller: tfPassword,
                        obscure: true),
                    _FormInputTextField(
                        hintText: "Name", controller: tfName, obscure: false),
                    _FormInputTextField(
                        hintText: "Lastname",
                        controller: tfLastname,
                        obscure: false),
                    _SigninButton(
                        formKey: formKey,tfUsername: tfUsername,tfPassword: tfPassword,tfName:tfName,tfLastname: tfLastname,)
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

class _FormInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;

  const _FormInputTextField(
      {required this.controller,
      required this.hintText,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return _InputTextFieldPadding(
      widget: _InputTextFormField(
        hint: hintText,
        textEditController: controller,
        obscureText: obscure,
      ),
    );
  }
}
/*
class _ObscureInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const _ObscureInputTextField(
      {required this.controller,
      required this.hintText}); //({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InputTextFieldPadding(
        widget: _InputTextFormField(
      hint: hintText,
      textEditController: controller,
      obscureText: true,
    ));
  }
}*/

class _SigninButton extends StatelessWidget {
  final TextEditingController tfUsername, tfPassword, tfName, tfLastname;
  GlobalKey<FormState> formKey;

  _SigninButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: ElevatedButton(
            onPressed: () {
              _signupProcess(context);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.pink),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white)),
            child: Text("Sign in",
                style: TextStyle(
                    fontSize: ResponsiveDesign.getScreenWidth() / 20))));
  }

  void _signupProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      String name = tfName.text;
      String lastname = tfLastname.text;
      var request = HttpRequestDoctor();
      Doctor doctor = Doctor(id: 0, roleId: EnumUserRole.DOCTOR.roleId, name: name, lastname:
      lastname, username: username, password:pass, totalPatientNumber: -11);
      request.signup(doctor).then((resp) async {
        // debugPrint(resp.body);
        Map<String, dynamic> jsonData = json.decode(resp.body);
        // print("res.body : ${resp.body}");
        var respEntity = ResponseEntity.fromJson(jsonData);

        if (!respEntity.success) {
          showInvalidUsername(context: context, msg: respEntity.message);
        } else {
          User user = UserFactory.createUser(respEntity.data);
          // saveUserData(context, user);
          // navigateToHomePage(context: context, roleId: user.roleId);
        }
      });
    }
  }

  void showInvalidUsername(
      {required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(msg));
  }

/*  void saveUserData(BuildContext context, User user) {
    SharedPref.setLoginDataUser(user).then((value) {
      context.read<DrawerCubit>().resetBody();
      context.read<AppBarCubit>().setTitleRoleName();
    });
  }*/

/* void navigateToHomePage(
      {required BuildContext context, required int roleId}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }*/
}

class _InputTextFieldPadding extends StatelessWidget {
  final StatelessWidget widget;

  const _InputTextFieldPadding({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ResponsiveDesign.getScreenWidth() / 30,
          right: ResponsiveDesign.getScreenWidth() / 30,
          bottom: ResponsiveDesign.getScreenWidth() / 25),
      child: widget,
    );
  }
}

class _InputTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditController;
  final bool obscureText;

  const _InputTextFormField(
      {required this.hint,
      required this.textEditController,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: _TextFieldInputLength.max,
      controller: textEditController,
      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) {
          return "Please enter $hint";
        }
        if (data.length < _TextFieldInputLength.min) {
          return "Please enter ${_TextFieldInputLength.min} or more  character";
        }
        if (data.length > _TextFieldInputLength.max) {
          return "Please enter ${_TextFieldInputLength.max} or less  character";
        }
        // return null;
      },
      decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(
              fontSize: ResponsiveDesign.getScreenWidth() / 23,
              color: ProductColor.black,
              fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle:
              TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: ProductColor.darkBlue)),
          filled: true,
          fillColor: ProductColor.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      style: TextStyle(
          fontSize: ResponsiveDesign.getScreenWidth() / 22,
          color: ProductColor.darkBlue),
    );
  }
}

class _TextFieldInputLength {
  static int min = 3;
  static int max = 10;
}
