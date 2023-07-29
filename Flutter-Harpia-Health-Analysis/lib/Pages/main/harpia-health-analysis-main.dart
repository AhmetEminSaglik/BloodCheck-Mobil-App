import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePage.dart';
import '../../core/ResponsiveDesign.dart';
import '../login/LoginPage.dart';

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
      // home: const HomePage(userRoleId: 3),
      home: const LoginPage(title: "Login"),
    );
  }
}

class TestClass extends StatefulWidget {
  const TestClass({Key? key}) : super(key: key);

  @override
  State<TestClass> createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("login"),
      ),
    );
  }
}
