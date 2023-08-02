import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/HomePage.dart';

class DrawerCubit extends Cubit<Widget> {
  Widget _body = const Text("Empty Text Widget");

  DrawerCubit() : super(HomePage().getUserPage());

  void updateBody(Widget newBody) {
    _body = newBody;
    emit(_body);
  }
}
