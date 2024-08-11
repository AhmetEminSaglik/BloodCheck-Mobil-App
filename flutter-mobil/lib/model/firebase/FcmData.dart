import 'package:logger/logger.dart';

class FcmData {
  late String? _msgTitle;
  late String? _msg;
  late bool? _showNotification;
  late int? _patientId;
  late int? _reasonCode;
  late String? _reasonSend;

  FcmData({
    url = "",
    msgTitle,
    msg,
    showNotification,
    patientId,
    reasonCode,
    reasonSend,
  }) {
    _msg = msg;
    _msgTitle = msgTitle;
    _showNotification = showNotification;
    _patientId = patientId;
    _reasonCode = reasonCode;
    _reasonSend = reasonSend;
  }

  static var log = Logger(printer: PrettyPrinter(colors: false));

  factory FcmData.fromJson(Map<String, dynamic> json) {
    log.i("Gelen Json : $json");

    json.forEach((key, value) {
      print('$key: $value\n');
    });
    print('-----------');

    return FcmData(
      msgTitle: json["msgTitle"] as String,
      msg: json["msg"] as String,
      patientId: int.parse(json["patientId"] as String),
      showNotification: bool.parse(json["showNotification"] as String),
      reasonCode: int.parse(json["reasonCode"] as String),
      reasonSend: json["reasonSend"] as String,
    );
  }

  @override
  String toString() {
    return 'FcmData{_msgTitle: $_msgTitle, _msg: $_msg, _showNotification: $_showNotification, _patientId: $_patientId, _reasonCode: $_reasonCode, _reasonSend: $_reasonSend}';
  }

  String get msg => _msg ?? "";

  String get msgTitle => _msgTitle ?? "";

  bool get showNotification => _showNotification ?? false;

  int get patientId => _patientId ?? -1;

  String get reasonSend => _reasonSend ?? "";

  int get reasonCode => _reasonCode ?? -1;
}
