class FcmData {
  late String _url;
  late String _msgTitle;
  late String _msg;
  late bool _showNotification;

  FcmData(
      {url = "", required msgTitle, required msg, required showNotification}) {
    _url = url;
    _msg = msg;
    _msgTitle = msgTitle;
    _showNotification = showNotification;
  }

  factory FcmData.fromJson(Map<String, dynamic> json) {
    bool showNotification = bool.parse(json["showNotification"] as String);
    return FcmData(
      msgTitle: json["msgTitle"] as String,
      msg: json["msg"] as String,
      url: json["url"] as String,
      showNotification: showNotification,
    );
  }

  @override
  String toString() {
    return 'FcmData{_url: $_url, _msgTitle: $_msgTitle, _msg: $_msg, _showNotification: $_showNotification}';
  }

  String get msg => _msg;

  String get msgTitle => _msgTitle;

  String get url => _url;

  bool get showNotification => _showNotification;
}
