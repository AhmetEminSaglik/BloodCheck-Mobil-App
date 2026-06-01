import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/AdminDrawer.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/DoctorDrawer.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/MainDrawer.dart';
import 'package:bloodcheck/Pages/afterlogin/homepage/drawer/PatientDrawer.dart';
import 'package:bloodcheck/util/AppBarUtil.dart';
import 'package:bloodcheck/util/FcmTokenUtils.dart';
import 'package:bloodcheck/util/ProductColor.dart';
import 'package:bloodcheck/util/SharedPrefUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  const HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  static var log = Logger(printer: PrettyPrinter(colors: false));

  int userId = SharedPrefUtils.getUserId();
  late final MainDrawer mainDrawer;
  late final AdminDrawer _adminDrawer;
  late final DoctorDrawer _doctorDrawer;
  late final PatientDrawer _patientDrawer;

  @override
  void initState() {
    super.initState();
    enableBackgroundExecution();
    prepareDrawer();
  }

  void prepareDrawer() {
    _adminDrawer = AdminDrawer();
    _doctorDrawer = DoctorDrawer();
    _patientDrawer = PatientDrawer(patientId: userId);
    mainDrawer =
        MainDrawer(drawerList: [_adminDrawer, _doctorDrawer, _patientDrawer]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtil.getAppBar(),
      drawer: mainDrawer,
      backgroundColor: ProductColor.bodyBackground,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: BlocBuilder<DrawerCubit, Widget>(
              builder: (builder, drawerClickBody) {
                return drawerClickBody;
              },
            ),
          )
        ],
      ),
    );
  }
}

void enableBackgroundExecution() async {
  // flutter_background kaldırıldı — flutter_foreground_task kullanıyoruz
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'bloodcheck_bg_channel',
      channelName: 'BloodCheck Background',
      channelDescription: 'BloodCheck arka plan servisi',
      onlyAlertOnce: true,
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: false,
      playSound: false,
    ),
    foregroundTaskOptions: ForegroundTaskOptions(
      eventAction: ForegroundTaskEventAction.repeat(5000),
      autoRunOnBoot: false,
      allowWakeLock: true,
    ),
  );
  FcmTokenUtils.listenBackground();
}
