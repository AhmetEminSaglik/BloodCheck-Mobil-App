import 'package:flutter_bloc/flutter_bloc.dart';

class FcmNotificationCubit extends Cubit<bool> {
  bool updateLineChart = false;
  bool letPermissionFcmNotifyPatientPage = false;

  FcmNotificationCubit() : super(false);

  void activateFcmNotifyPermission() {
    letPermissionFcmNotifyPatientPage = true;
    // emit(letPermissionFcmNotifyPatientPage); // if I add this line, retrive data 3 times.
    //if I do not add, it works just once.
  }

  void deactivateFcmNotifyPermission() {
    letPermissionFcmNotifyPatientPage = false;
    // emit(letPermissionFcmNotifyPatientPage);
  }

  void activateUpdatePatientLineChart() {
    if (letPermissionFcmNotifyPatientPage) {
      updateLineChart = true;
      emit(updateLineChart);
    }
    // deactivateUpdatePatientLineChart();
  }

  void deactivateUpdatePatientLineChart() {
    updateLineChart = false;
    emit(updateLineChart);
  }
}
