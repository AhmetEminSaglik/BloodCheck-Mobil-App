import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/MainDrawer.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

import '../../../../util/CustomNotification.dart';
import '../../../../util/FcmTokenUtils.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomNotificationUtil.initialize();
    print("Created TOKEN :  ${FcmTokenUtils.getToken()}");
    FcmTokenUtils.listenFcm(context);
    runBackground();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProductColor.appBarBackgroundColor,
        title:
            BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
          return titleWidget;
        }),
      ),
      drawer: const MainDrawer(),
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

void runBackground() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "flutter_background example app",
    notificationText:
        "Background notification for keeping the example app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon:
        AndroidResource(name: 'background_icon', defType: 'drawable'),
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);

  if (success) {
    await FlutterBackground.enableBackgroundExecution();
  }

  if (FlutterBackground.isBackgroundExecutionEnabled) {
    print("--------> BACKGROUND DINLENIYOR ");
    print("---------------> ${FlutterBackground.isBackgroundExecutionEnabled}");
    CustomNotificationUtil.showNotification("Background Test : ",
        "${FlutterBackground.isBackgroundExecutionEnabled}");
    print(
        "------------> IS ENABLED ? FlutterBackground.hasPermissions : ${FlutterBackground.isBackgroundExecutionEnabled}");
  }
}
/*Future<void> requestPermission() async {
  // final PermissionStatus status = await Permission.foregroundService.request();
  if (status.isGranted) {
    // İzin verildi, arka planda çalışabilirsiniz.
  } else {
    // İzin verilmedi, kullanıcıya açıklama yapabilirsiniz.
  }
}*/
