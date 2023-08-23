import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotificationUtil {
  static var _flp = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    var androidSetup =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosSetup = const DarwinInitializationSettings();
    var instalationSetup =
        InitializationSettings(android: androidSetup, iOS: iosSetup);
    await _flp.initialize(instalationSetup,
        onDidReceiveNotificationResponse: _selectNotification);
  }

  static Future<void> _selectNotification(
      NotificationResponse notificationResponse) async {
    var payload = notificationResponse.payload;
    if (payload != null) {
      print("Notification is selected $payload");
    }
  }

  static Future<void> showNotification(String title, String msg) async {
    var androidNotificationDetail = const AndroidNotificationDetails(
        ("channel Id"), "channel Name",
        channelDescription: "Demo channel description",
        priority: Priority.high,
        importance: Importance.max);

    var iosNotificationDetail = const DarwinNotificationDetails();
    var notificationDetail = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);

    await _flp.show(0, title, msg, notificationDetail,
        payload: "Burayi ANLAMADIM ???");
  }
}
