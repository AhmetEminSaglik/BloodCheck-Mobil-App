import '../../util/CustomLog.dart';

class FcmNotification {
  static CustomLog log = CustomLog(className: "FcmNotification");

  late String _title;
  late String _body;

  FcmNotification({required title, required body}) {
    _title = title;
    _body = body;
  }

  factory FcmNotification.fromJson(Map<String, dynamic> json) {
    log.info('gelen json : $json');
    return FcmNotification(
        title: json["title"] as String, body: json["body"] as String);
  }

  @override
  String toString() {
    return 'FcmNotification{_title: $_title, _body: $_body}';
  }

  String get body => _body;

  String get title => _title;
}
