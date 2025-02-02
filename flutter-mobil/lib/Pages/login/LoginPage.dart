import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloodcheck/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/users/patient/HomePage.dart';
import 'package:bloodcheck/Product/CustomButton.dart';
import 'package:bloodcheck/business/factory/UserFactory.dart';
import 'package:bloodcheck/core/ResponsiveDesign.dart';
import 'package:bloodcheck/httprequest/HttpRequestLogin.dart';
import 'package:bloodcheck/httprequest/ResponseEntity.dart';
import 'package:bloodcheck/model/firebase/FcmData.dart';
import 'package:bloodcheck/model/user/User.dart';
import 'package:bloodcheck/util/CustomAlertDialog.dart';
import 'package:bloodcheck/util/CustomNotification.dart';
import 'package:bloodcheck/util/CustomSnackBar.dart';
import 'package:bloodcheck/util/FcmTokenUtils.dart';
import 'package:bloodcheck/util/ProductColor.dart';
import 'package:bloodcheck/util/SharedPrefUtils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var log = Logger(printer: PrettyPrinter(colors: false));

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({super.key, required this.title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String token;
  var formKey = GlobalKey<FormState>();

/*  Future<void> setUserDataSharedPref() async {
    var sp = await SharedPreferences.getInstance();
  }*/

  TextEditingController tfUsername = TextEditingController();
  TextEditingController tfPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    autoLogin();
    // log.i("Created TOKEN :  ${FcmTokenUtils.getToken()}");
    // FcmTokenUtils.listenFcm(context);
    func();
  }

  void func() async {
    await CustomNotificationUtil.initialize();
    // FirebaseMessaging.instance;
    await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.subscribeToTopic("Istanbul");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // log.i("GELEN MESSAGE : \n$message");
      // print('-----------');
      // print("message.notification.title : ${message.notification?.title}");
      // print("message.notification.body : ${message.notification?.body}");
      // print('-----------');
      FcmData fcmData = FcmTokenUtils.parseMapToFcmData(message.data);
      // log.i("gelen fcm : \n $fcmData");

      FcmTokenUtils.processSendReason(context, fcmData);
      if (fcmData.showNotification) {
        String title = message.notification?.title ?? "";
        String body = message.notification?.body ?? "";
        if (!title.isEmpty) {
          CustomNotificationUtil.showNotification(
              message.notification?.title ?? "Notification TITLE is NULL",
              message.notification?.body ?? "Notification BODY is NULL");
        }
      }
    });
  }

  void autoLogin() async {
    await SharedPrefUtils.initiliazeSharedPref();
    String username = SharedPrefUtils.getUsername();
    String password = SharedPrefUtils.getPassword();
    if (username.isNotEmpty && password.isNotEmpty) {
      ResponseEntity? respEntity;
      await login(username: username, password: password)
          .then((value) => respEntity = value);
      if (respEntity != null && respEntity!.success) {
        User user = UserFactory.createUserByLogin(respEntity!.data);
        // saveUserData(context, user);
        updateCubits(context);
        navigateToHomePage(context: context, roleId: user.roleId);
      }
    }
  }

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
                    ),
                    SizedBox(height: 25),
                    _HelpButton()
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
        child: Image.asset("assets/blood_icon_logo.png"),
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
          bottom: ResponsiveDesign.getScreenWidth() / 25),
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

class _HelpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.5,
      height: ResponsiveDesign.getScreenHeight() / 15,
      child: CustomButton(
        action: () {
          String msg = "username: doctor1"
              "\npassword: pass"
              "\nor"
              "\nusername: patient1"
              "\npassword: pass"
              "\n\n5 Doctor and 20 patients"
              "\nare saved for demo."
              "\n\nYou can switch number"
              "\nfor doctor 1-5,"
              "\nfor patient 1-20."
              "\n\nHopes you having fun.";
          showDialog(
              context: context,
              builder: (builder) => CustomAlertDialog.getAlertDialogHowToLogin(
                  context: context, title: "How to Login?", msg: msg));
        },
        textColor: ProductColor.white,
        backgroundColor: ProductColor.bodyBackground,
        text: "How to Login?",
      ),
    );
    // TODO: implement build
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
      child: CustomButton(
        action: () {
          loginManuelProcess(context);
        },
        textColor: ProductColor.white,
        backgroundColor: ProductColor.pink,
        text: "Login",
      ),
    );
  }

  void loginManuelProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      ResponseEntity? respEntity;

      try {
        await login(username: username, password: pass)
            .timeout(Duration(seconds: 5))
            .then((value) => respEntity = value);

        if (respEntity != null && !respEntity!.success) {
          showInvalidUsernameOrPassword(
              context: context, msg: respEntity!.message);
        } else {
          // log.i("Gelen Data ${respEntity!.data}");
          User user = UserFactory.createUserByLogin(respEntity!.data);
          saveUserData(context, user);
          navigateToHomePage(context: context, roleId: user.roleId);
        }
      } on SocketException {
        String msg = "Could not connect to server. Server could be down.";
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.getSnackBar(msg));
      } on TimeoutException {
        String msg = "Timeout: Unable to reach the server.";
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.getSnackBar(msg));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar.getSnackBar(e.toString()));
      }
    }
  }
/*void loginManuelProcess(BuildContext context) async {
    bool controlResult = formKey.currentState!.validate();
    if (controlResult) {
      String username = tfUsername.text;
      String pass = tfPassword.text;
      ResponseEntity? respEntity;
      await login(username: username, password: pass)
          .then((value) => respEntity = value);

      if (respEntity != null && !respEntity!.success) {
        showInvalidUsernameOrPassword(
            context: context, msg: respEntity!.message);
      } else {
        log.i("Gelen Data ${respEntity!.data}");
        User user = UserFactory.createUser(respEntity!.data);
        saveUserData(context, user);
        navigateToHomePage(context: context, roleId: user.roleId);
      }
    }
  }*/
}

Future<ResponseEntity?> login(
    {required String username, required String password}) async {
  var request = HttpRequestLogin();
  ResponseEntity? respEntity;
  await request.login(username, password).then((resp) async {
    Map<String, dynamic> jsonData = json.decode(resp.body);
    respEntity = ResponseEntity.fromJsonForLogin(jsonData);
    return respEntity;
  });
  return respEntity;
}

void showInvalidUsernameOrPassword(
    {required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar.getSnackBar(msg));
}

void saveUserData(BuildContext context, User user) async {
  // log.i("Login page -> saveUserData -> User : $user");
  await SharedPrefUtils.setLoginDataUser(user).then((value) {});
  updateCubits(context);
}

void updateCubits(BuildContext context) {
  context.read<DrawerCubit>().resetBody();
  context.read<AppBarCubit>().setTitleRoleName();
}

void navigateToHomePage({required BuildContext context, required int roleId}) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const HomePage()));
}

class _TextFieldInputLength {
  static int min = 3;
  static int max = 10;
}
