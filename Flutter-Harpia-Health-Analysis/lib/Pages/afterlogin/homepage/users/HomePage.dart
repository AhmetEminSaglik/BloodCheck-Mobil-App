import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/DrawerCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/drawer/MainDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();

  HomePage({super.key});
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent,
        title:
            BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
          return titleWidget;
        }),
      ) /*  BlocBuilder<AppBarCubit, AppBar>(builder: (builder, appBar) {
            return appBar.preferredSize;
          },
        )*/
      ,
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
      drawer: const MainDrawer(),
    );
  }
}
