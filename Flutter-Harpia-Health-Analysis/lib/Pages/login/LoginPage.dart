import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePage.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/model/user/User.dart';
import 'package:flutter_harpia_health_analysis/business/factory/UserFactory.dart';
import 'package:flutter_harpia_health_analysis/util/CustomSnackBar.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestUser.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({super.key, required this.title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();

  Future<void> setUserDataSharedPref() async {
    var sp = await SharedPreferences.getInstance();
  }

  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    _LoginPageLogo(),
                    _UsernameInputTextField(controller: tfUsername),
                    _PasswordInputTextField(
                      controller: tfPassword,
                    ),
                    _LoginButton(
                      formKey: formKey,
                      tfUsername: tfUsername,
                      tfPassword: tfPassword,
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

class _LoginPageLogo extends StatelessWidget {
  const _LoginPageLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveDesign.getScreenHeight() / 50),
      child: SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 4,
        child: Image.asset("images/harpia_logo.jpg"),
      ),
    );
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
          bottom: ResponsiveDesign.getScreenWidth() / 30),
      child: widget,
    );
  }
}

class _UsernameInputTextField extends StatelessWidget {
  final TextEditingController controller;

  _UsernameInputTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _InputTextFieldPadding(
      widget: _InputTextFormField(
        hint: "Username",
        textEditController: controller,
        obscureText: false,
      ),
    );
  }
}

class _PasswordInputTextField extends StatelessWidget {
  final TextEditingController controller;

  _PasswordInputTextField(
      {required this.controller}); //({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InputTextFieldPadding(
        widget: _InputTextFormField(
      hint: "Password",
      textEditController: controller,
      obscureText: true,
    ));
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
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
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

class _LoginButton extends StatelessWidget {
  final TextEditingController tfUsername, tfPassword;
  GlobalKey<FormState> formKey;

  _LoginButton(
      {required this.formKey,
      required this.tfUsername,
      required this.tfPassword}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth() / 1.5,
        height: ResponsiveDesign.getScreenHeight() / 15,
        child: ElevatedButton(
            onPressed: () {
              loginProcess(context);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.pink),
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.white)),
            child: Text("login",
                style: TextStyle(
                    fontSize: ResponsiveDesign.getScreenWidth() / 20))));
  }

  void loginProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      var request = HttpRequestUser();
      request.login(username, pass).then((resp) async {
        // debugPrint(resp.body);
        Map<String, dynamic> jsonData = json.decode(resp.body);
        // print("res.body : ${resp.body}");
        var respEntity = ResponseEntity.fromJson(jsonData);

        if (!respEntity.success) {
          showInvalidUsernameOrPassword(
              context: context, msg: respEntity.message);
        } else {
          User user = UserFactory.createUser(respEntity.data);
          saveUserData(user);
          navigateToHomePage(context: context, roleId: user.roleId);
        }
      });
    }
  }

  void showInvalidUsernameOrPassword(
      {required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(msg));
  }

  void saveUserData(User user) {
    SharedPref.setLoginDataUser(user);
  }

  void navigateToHomePage(
      {required BuildContext context, required int roleId}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(userRoleId: roleId)));
  }
}

class _TextFieldInputLength {
  static int min = 3;
  static int max = 10;
}
