class FcmData {
  late String _url;
  late String _msgTitle;
  late String _msg;
  late bool _showNotification;
  late int _patientId;

  FcmData(
      {url = "",
      required msgTitle,
      required msg,
      required showNotification,
      required int patientId}) {
    _url = url;
    _msg = msg;
    _msgTitle = msgTitle;
    _showNotification = showNotification;
    _patientId = patientId;
  }

  factory FcmData.fromJson(Map<String, dynamic> json) {
    bool showNotification = bool.parse(json["showNotification"] as String);
    int patientId=int.parse(json["patientId"] as String);
    return FcmData(
      msgTitle: json["msgTitle"] as String,
      msg: json["msg"] as String,
      url: json["url"] as String,
      patientId:patientId,
      showNotification: showNotification,
    );
  }

  @override
  String toString() {
    return 'FcmData{_url: $_url, _msgTitle: $_msgTitle, _msg: $_msg, _showNotification: $_showNotification, _patientId: $_patientId}';
  }

  String get msg => _msg;

  String get msgTitle => _msgTitle;

  String get url => _url;

  bool get showNotification => _showNotification;

  int get patientId => _patientId;
}
