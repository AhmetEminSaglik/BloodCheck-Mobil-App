import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/MainDrawer.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

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
    test();
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

void test() async {
  const androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "flutter_background example app",
    notificationText:
        "Background notification for keeping the example app running in the background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );
  bool success =
      await FlutterBackground.initialize(androidConfig: androidConfig);
  if(FlutterBackground.isBackgroundExecutionEnabled){
    FcmTokenUtils.listenBackground();
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
