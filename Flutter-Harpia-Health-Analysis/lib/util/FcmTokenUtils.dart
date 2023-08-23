import 'package:firebase_messaging/firebase_messaging.dart';

class FcmTokenUtils {
  static late String _token;

  static Future<void> createToken() async {
    _token = (await FirebaseMessaging.instance.getToken())!;
  }

  static String getToken() {
    return _token;
  }

  static listenFcm() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
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
