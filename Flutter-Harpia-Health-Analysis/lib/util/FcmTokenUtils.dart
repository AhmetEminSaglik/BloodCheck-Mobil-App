import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmMessage.dart';
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

  static listenFcm()  {
    try{
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Got a message whilst in the foreground!');
      print('--> Got a message whilst in the foreground!$message');
      print('----> Message data: ${message.data}');


      // CustomNotification.showNotification(message.data);
      parseMapToString(message.data);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    }
    catch(e){
      print("exception : $e");

    }
  }

  static String parseMapToString(Map<String, dynamic> map) {
    String data = "";
    for (var entry in map.entries) {
      print("entry.key : ${entry.key}");
      print("entry.value : ${entry.value}");
      data += entry.value;
    }
    print("DATA : $data ");
    print("map : $map ");
    FcmMessage message = FcmMessageFactory.createFcmMessage(map);
    print("FcmMessage : $message");
    // CustomNotification.showNotification(data);

    return data;
  }

  static listenBackground() {
    FirebaseMessaging.onBackgroundMessage((message) {
      return _backgroundHandler(message);
    });
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    print('Got a message whilst in the background!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }
}
