import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  static var _flp = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification(String text) async {
    var androidNotificationDetail = const AndroidNotificationDetails(
        "channelId", "channelName",
        channelDescription: "Demo channel description",
        priority: Priority.high,
        importance: Importance.max);
    var iosNotificationDetail = const DarwinNotificationDetails(); // Doğru iOS ayrıntıları kullanımı
    var notificationDetail = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);
    await _flp.show(1, "Demo", text, notificationDetail,
        payload: "");
  }
}

/*
class CustomNotification {
  static var _flp = FlutterLocalNotificationsPlugin();

  static Future<void> showNotification(String text) async {
    var androidNotificationDetail = const AndroidNotificationDetails(
        ("channel Id"), "channel Name",
        channelDescription: "Demo channel description",
        priority: Priority.high,
        importance: Importance.max);

    var iosNotificationDetail = const DarwinNotificationDetails();
    var notificationDetail = NotificationDetails(
        android: androidNotificationDetail, iOS: iosNotificationDetail);

    await _flp.show(0, " Demo", text, notificationDetail,
        payload: "Burayi ANLAMADIM ???");
  }
}
*/
