import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/EnumDiseaseType.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/CustomAlertDialog.dart';
import '../../../business/factory/UserFactory.dart';
import '../../../core/ResponsiveDesign.dart';
import '../../../httprequest/ResponseEntity.dart';
import '../../../model/user/Patient.dart';
import '../../../model/user/User.dart';
import '../../../util/ProductColor.dart';
import 'dart:convert';

class PatientSignUpPage extends StatefulWidget {
  const PatientSignUpPage({Key? key}) : super(key: key);

  @override
  State<PatientSignUpPage> createState() => _PatientSignUpPageState();
}

final _formKey = GlobalKey<FormState>();
// final _diseaseKey = GlobalKey<FormFieldState>();

class _PatientSignUpPageState extends State<PatientSignUpPage> {
  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();
  TextEditingController tfName = TextEditingController();
  TextEditingController tfLastname = TextEditingController();

  // int selectedDiseaseValue = -1;
  _DiseaseDropdownMenuButton diseaseDropDownMenu = _DiseaseDropdownMenuButton();

  // int diseaseId=
  // var DiseaseDropdownButton =  _DiseaseDropdownMenuButton();

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
                key: _formKey,
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
                    // const _DiseaseDropdownMenuButton(),
                    diseaseDropDownMenu,
                    /*_DiseaseDropdownMenuButton(
                        selectedDiseaseValue: selectedDiseaseValue),*/
                    _SignUpButton(
                      formKey: _formKey,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
                      tfName: tfName,
                      tfLastname: tfLastname,
                      diseaseDropDownMenu: diseaseDropDownMenu,
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

class _DiseaseDropdownMenuButton extends StatefulWidget {
  int selectedDiseaseValue = -1;

  _DiseaseDropdownMenuButton();

  @override
  State<_DiseaseDropdownMenuButton> createState() =>
      _DiseaseDropdownMenuButtonState();
}

class _DiseaseDropdownMenuButtonState
    extends State<_DiseaseDropdownMenuButton> {
  final items = [-1, EnumDiseaseType.DIABETIC.id, EnumDiseaseType.CANCER.id];

  DropdownMenuItem<int> buildMenuItem(int id) => DropdownMenuItem(
      value: id,
      child: Text(
        id > 0 ? EnumDiseaseType.getDiseaseName(id) : "Select Disease",
        style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 23),
      ));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.5,
      child: Container(
        margin:
            EdgeInsets.only(bottom: ResponsiveDesign.getScreenHeight() / 25),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: ResponsiveDesign.getScreenWidth() / 30,
              right: ResponsiveDesign.getScreenWidth() / 30),
          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<int>(
                iconSize: ResponsiveDesign.getScreenWidth() / 15,
                value: widget.selectedDiseaseValue,
                items: items.map(buildMenuItem).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.selectedDiseaseValue = value!;
                    print(
                        "widget.selectedDiseaseValue ${widget.selectedDiseaseValue}");
                  });
                },
                validator: (data) {
                  if (data == null || data < 0) {
                    return "Select Diseae";
                  }

                  // if (data.length < _TextFieldInputLength.min) {
                  // return "Please enter ${_TextFieldInputLength.min} or more  character";
                  // }
                  // if (data.length > _TextFieldInputLength.max) {
                  // return "Please enter ${_TextFieldInputLength.max} or less  character";
                  // }
                  return null;
                },
                hint: const Text("Select Disease"),
                isExpanded: true,
              ),
            ),
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

class _SignUpButton extends StatelessWidget {
  final TextEditingController tfUsername, tfPassword, tfName, tfLastname;
  final _DiseaseDropdownMenuButton diseaseDropDownMenu;
  GlobalKey<FormState> formKey;

  _SignUpButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword,
      required this.tfName,
      required this.tfLastname,
      required this.diseaseDropDownMenu}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: ElevatedButton(
            onPressed: () {
              _signUpProcess(context, diseaseDropDownMenu);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.pink),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white)),
            child: Text("Sign Up",
                style: TextStyle(
                    fontSize: ResponsiveDesign.getScreenWidth() / 20))));
  }

  void resetFormData() {
    _formKey.currentState!.reset();
  }

  void _signUpProcess(BuildContext context,
      _DiseaseDropdownMenuButton diseaseDropdownMenuButton) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      String name = tfName.text;
      String lastname = tfLastname.text;
      int diseaseTypeId = diseaseDropdownMenuButton.selectedDiseaseValue;
      var request = HttpRequestPatient();
      Patient patient = Patient(
        id: 0,
        roleId: EnumUserRole.PATIENT.roleId,
        name: name,
        lastname: lastname,
        username: username,
        password: pass,
        diseaseTypeId: diseaseTypeId,
      );
      request.signUp(patient).then((resp) async {
        // debugPrint(resp.body);
        Map<String, dynamic> jsonData = json.decode(resp.body);
        // print("res.body : ${resp.body}");
        var respEntity = ResponseEntity.fromJson(jsonData);
        if (!respEntity.success) {
          showAlertDialogInvalidUsername(
              context: context, msg: respEntity.message);
        } else {
          User user = UserFactory.createUser(respEntity.data);
          showAlertDialogDoctorSignUpSuccessfully(
              context: context, msg: respEntity.message);
          /*         List<TextEditingController> list = [
            tfUsername,
            tfPassword,
            tfName,
            tfLastname
          ];
          resetTextFields(list);*/
          // formKey.currentState?.reset();
          // resetFormData();
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
            roleId: EnumUserRole.PATIENT.roleId));
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
            roleId: EnumUserRole.PATIENT.roleId));
  }
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
          top: ResponsiveDesign.getScreenWidth() / 30,
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
