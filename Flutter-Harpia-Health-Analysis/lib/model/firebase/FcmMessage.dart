import 'package:flutter_harpia_health_analysis/model/firebase/FcmNotification.dart';

import 'FcmData.dart';

class FcmMessage {
  // late FcmNotification _notification;
  late FcmData _fcmData;
  FcmMessage({required fcmData}) {
    _fcmData = fcmData;
  }

  /*FcmMessage({required notification, required fcmData}) {
    _notification = notification;
    _fcmData = fcmData;
  }*/

  factory FcmMessage.fromJson(Map<String, dynamic> json) {
    return FcmMessage(
        // notification: FcmNotification.fromJson(json),
        fcmData: FcmData.fromJson(json));
  }


  @override
  String toString() {
    return 'FcmMessage{_fcmData: $_fcmData}';
  }

  FcmData get fcmData => _fcmData;

  // FcmNotification get notification => _notification;
}
