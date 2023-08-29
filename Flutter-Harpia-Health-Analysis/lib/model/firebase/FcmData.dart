class FcmData {
  late String _url;
  late String _msgTitle;
  late String _msg;

  FcmData({required url, required msgTitle, required msg}) {
    _url = url;
    _msg = msg;
    _msgTitle = msgTitle;
  }

  factory FcmData.fromJson(Map<String, dynamic> json) {
    return FcmData(
      url: json["url"] as String,
      msg: json["msg"] as String,
      msgTitle: json["msgTitle"] as String,
    );
  }

  @override
  String toString() {
    return 'FcmData{_url: $_url, _msgTitle: $_msgTitle, _msg: $_msg}';
  }

  String get msg => _msg;

  String get msgTitle => _msgTitle;

  String get url => _url;
}
