import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmData.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmMessage.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmNotificationCubit.dart';
import 'package:flutter_harpia_health_analysis/util/CustomNotification.dart';

import '../business/factory/FcmMessageFactory.dart';

class FcmTokenUtils {
  static late String _token;

  static Future<void> createToken() async {
    _token = (await FirebaseMessaging.instance.getToken())!;
  }

  static String getToken() {
    return _token;
  }

  static listenFcm(BuildContext context) {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // print('Got a message whilst in the foreground!');
        print('--> LISTEN GELDI data ! ${message.data}');

        context.read<FcmNotificationCubit>().activateUpdatePatientLineChart();

        // print('--> Got a message whilst in the foreground!$message');
        print('----> Message predata: ${message.data}');

        // CustomNotification.showNotification(message.predata);
        FcmData fcmData = parseMapToFcmData(message.data);
        if (fcmData.showNotification) {
          print("---> fcmdata.showNotification : ${fcmData.showNotification}");
          CustomNotificationUtil.showNotification(
              fcmData.msgTitle, fcmData.msg);
        } else {
          print("---> fcmdata showNotification is FALSE : $fcmData");
        }
        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      });
    } catch (e) {
      print("exception : $e");
    }
  }

  static FcmData parseMapToFcmData(Map<String, dynamic> map) {
    String data = "";
    for (var entry in map.entries) {
      print("entry.key : ${entry.key}");
      print("entry.value : ${entry.value}");
      data += entry.value;
    }
    print("DATA : $data ");
    print("map : $map ");
    FcmMessage message = FcmMessageFactory.createFcmMessage(map);
    return message.fcmData;
    /* print("FcmMessage : $message");
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
    print('Got a message whilst in the background!');
    print('Message predata: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      final title = message.notification?.title ?? "Title is Null";
      final body = message.notification?.body ?? "Body is Null";

      CustomNotificationUtil.showNotification(title, body);
    }
  }
}
