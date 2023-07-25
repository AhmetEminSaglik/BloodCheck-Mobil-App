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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _LoginPageLogo(),
              // SizedBox(height: ResponsiveDesign.getScreenHeight() / 15),
              _UsernameInputTextField(),
              SizedBox(),
              _PasswordInputTextField(),
              // SizedBox(height: ResponsiveDesign.getScreenHeight() / 30),
              _LoginButton()
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

class _UsernameInputTextField extends StatelessWidget {
  const _UsernameInputTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _InputTextFieldPadding(
      widget: _InputTextField(
        hint: "Username",
      ),
    );
  }
}

class _InputTextFieldPadding extends StatelessWidget {
  final StatelessWidget widget;

  const _InputTextFieldPadding({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    ResponsiveDesign(mediaQueryData: MediaQuery.of(context));
    return Padding(
      padding: EdgeInsets.only(
          left: ResponsiveDesign.getScreenWidth() / 30,
          right: ResponsiveDesign.getScreenWidth() / 30,
          bottom: ResponsiveDesign.getScreenWidth() / 30),
      child: widget,
    );
  }
}

class _PasswordInputTextField extends StatelessWidget {
  const _PasswordInputTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _InputTextFieldPadding(
        widget: _InputTextField(hint: "Password"));
  }
}

class _InputTextField extends StatelessWidget {
  final String hint;

  const _InputTextField({super.key, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key /*,required this.screenInfo*/});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 1.5,
      height: ResponsiveDesign.getScreenHeight() / 15,
      child: ElevatedButton(
          onPressed: () {
            print("login is successfull");
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
