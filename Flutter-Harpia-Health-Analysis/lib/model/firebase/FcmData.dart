class FcmData {
  late String _url;
  late String _dl;

  FcmData({required url, required dl}) {
    _url = url;
    _dl = dl;
  }

  factory FcmData.fromJson(Map<String, dynamic> json) {
    return FcmData(
      url: json["url"] as String,
      dl: json["dl"] as String,
    );
  }

  @override
  String toString() {
    return 'FcmData{_url: $_url, _dl: $_dl}';
  }

  String get dl => _dl;

  String get url => _url;
}
