import 'package:auto_orientation/auto_orientation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/profile/ProfilUpdatedCubit.dart';
import 'package:flutter_harpia_health_analysis/firebase_options.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmNotificationCubit.dart';
import 'package:flutter_harpia_health_analysis/util/FcmTokenUtils.dart';
import 'Pages/afterlogin/homepage/users/patient/DetailLineChartCubit.dart';
import 'core/ResponsiveDesign.dart';
import 'Pages/login/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmTokenUtils.createToken();
  AutoOrientation.portraitAutoMode();
  runApp(const MyApp());
}
/*
void test() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    print('--> Got a message whilst in the foreground!$message');
    print('----> Message predata: ${message.data}');

    // CustomNotification.showNotification(message.predata);
    // parseMapToString(message.predata);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveDesign(mediaQueryData: MediaQuery.of(context));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerCubit()),
        BlocProvider(create: (context) => AppBarCubit()),
        BlocProvider(create: (context) => FcmNotificationCubit()),
        BlocProvider(create: (context) => ProfilUpdatedCubit()),
        BlocProvider(create: (context) => DetailLineChartCubit()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home:  HomePage(),
        home: LoginPage(title: "Login"),
      ),
    );
  }
}
