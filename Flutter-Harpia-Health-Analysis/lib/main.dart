import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/firebase_options.dart';
import 'package:flutter_harpia_health_analysis/util/CustomNotification.dart';
import 'package:flutter_harpia_health_analysis/util/FcmTokenUtils.dart';
import 'core/ResponsiveDesign.dart';
import 'Pages/login/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FcmTokenUtils.createToken();
  print("Created TOKEN :  ${FcmTokenUtils.getToken()}");
  FcmTokenUtils.listenFcm();
  // FcmTokenUtils?.listenBackground();
  runApp(const MyApp());
  CustomNotificationUtil.initialize();
}

void test() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    print('--> Got a message whilst in the foreground!$message');
    print('----> Message data: ${message.data}');

    // CustomNotification.showNotification(message.data);
    // parseMapToString(message.data);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveDesign(mediaQueryData: MediaQuery.of(context));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DrawerCubit()),
        BlocProvider(create: (context) => AppBarCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home:  HomePage(),
        home: const LoginPage(title: "Login"),
      ),
    );
  }
}
