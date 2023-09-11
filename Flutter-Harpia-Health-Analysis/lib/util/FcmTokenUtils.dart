import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmData.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmMessage.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmNotificationCubit.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/enum/EnumFcmMessageReason.dart';
import 'package:flutter_harpia_health_analysis/util/CustomNotification.dart';

import '../business/factory/FcmMessageFactory.dart';
import 'CustomLog.dart';

class FcmTokenUtils {
  static CustomLog log = CustomLog(className: "FcmTokenUtils");

  static late String _token;

  static Future<void> createToken() async {
    _token = (await FirebaseMessaging.instance.getToken())!;
  }

  static String getToken() {
    return _token;
  }

  static int? _viewPatientIdPage;

  static updatePatientId(int patientId) {
    _viewPatientIdPage = patientId;
  }

  static listenFcm(BuildContext context) {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log.info('--> LISTEN GELDI data ! $message');
        log.info('----> Message predata: ${message.data}');

        // CustomNotification.showNotification(message.predata);
        FcmData fcmData = parseMapToFcmData(message.data);

        if (_viewPatientIdPage != fcmData.patientId) {
          context.read<FcmNotificationCubit>().activateUpdatePatientLineChart();
        }

        processSendReason(fcmData.reasonCode);

        if (fcmData.showNotification) {
          CustomNotificationUtil.showNotification(
              fcmData.msgTitle, fcmData.msg);
        }
        /*    if (message.notification != null) {
          log.info(
              'Message also contained a notification: ${message.notification}');
        }*/
      });
    } catch (e) {
      // log.error(msgTitle: "FcmTokenUtils Exception", msg: "$e");
      log.error("Exception Occurred $e");
    }
  }

  static void processSendReason(int code) {
    if (code ==
        EnumFcmMessageReason.getCodeOfReason(
            EnumFcmMessageReason.UPDATE_LINE_CHART.name)) {
      log.todo(" CODE : $code --> Line Chart update islemi eklenecek --> Bu zaten yapildi sadece buraya eklenmeli");
    }
    if (code ==
        EnumFcmMessageReason.getCodeOfReason(
            EnumFcmMessageReason.UPDATE_SENSOR_TIMER.name)) {
      log.todo(" CODE $code --> Sensor update islemi eklenecek -> Sadece Patient telefonu icin");
    }
    log.todo(" --> Sensor update islemi eklenecek -> Sadece Patient telefonu icin");
    log.todo(" --> Line Chart update islemi eklenecek --> Bu zaten yapildi sadece buraya eklenmeli");

  }

  static FcmData parseMapToFcmData(Map<String, dynamic> map) {
    // String data = "";
    /*for (var entry in map.entries) {
      log.info("entry.key : ${entry.key}");
      log.info("entry.value : ${entry.value}");
      data += entry.value;
    }
    log.info("DATA : $data ");
    log.info("map : $map ");*/
    FcmMessage message = FcmMessageFactory.createFcmMessage(map);
    return message.fcmData;
    /* log.info("FcmMessage : $message");
    CustomNotificationUtil.showNotification(
        message.fcmData.msgTitle, message.fcmData.msg);
    return data;*/
  }

  static listenBackground() {
    FirebaseMessaging.onBackgroundMessage((message) {
      return _backgroundHandler(message);
    });
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    // log.info('Got a message whilst in the background!');
    // log.info('Message predata: ${message.data}');

    if (message.notification != null) {
      // log.info(
      //     'Message also contained a notification: ${message.notification}');
      final title = message.notification?.title ?? "Title is Null";
      final body = message.notification?.body ?? "Body is Null";
      CustomNotificationUtil.showNotification(title, body);
    }
  }
}
