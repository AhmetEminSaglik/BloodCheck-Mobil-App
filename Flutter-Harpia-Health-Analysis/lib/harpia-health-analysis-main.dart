import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'core/ResponsiveDesign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveDesign(mediaQueryData: MediaQuery.of(context));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Login Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({super.key, required this.title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameEditCont = TextEditingController();
  TextEditingController passwordEditCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _LoginPageLogo(),
              _UsernameInputTextField(controller: usernameEditCont),
              _PasswordInputTextField(
                controller: passwordEditCont,
              ),
              _LoginButton(
                usernameEditCont: usernameEditCont,
                passwordEditCont: passwordEditCont,
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
      widget: _InputTextField(
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
        widget: _InputTextField(
      hint: "Password",
      textEditController: controller,
      obscureText: true,
    ));
  }
}

class _InputTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditController;
  final bool obscureText;

  const _InputTextField(
      {required this.hint,
      required this.textEditController,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditController,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(fontSize: ResponsiveDesign.getScreenWidth()/22),
          hintText: hint,
          hintStyle: TextStyle(fontSize: ResponsiveDesign.getScreenWidth()/22),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))
      ),
      style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth()/22),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final TextEditingController usernameEditCont, passwordEditCont;

  _LoginButton(
      {required this.usernameEditCont,
      required this.passwordEditCont}); //({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.5,
      height: ResponsiveDesign.getScreenHeight() / 15,
      child: ElevatedButton(
          onPressed: () {
            print("username : ${usernameEditCont.text}");
            print("password : ${passwordEditCont.text}");
          },
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.pink),
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white)),
          child: Text(Intl.message("login", name: "login|"),
              style:
                  TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20))),
    );
  }
}
