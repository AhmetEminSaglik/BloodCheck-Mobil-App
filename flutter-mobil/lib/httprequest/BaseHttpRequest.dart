class BaseHttpRequestConfig {
  // static const String _localhost = "http://10.0.2.2:";
  // static const String _port = "8081";
  // static const String remoteIp = "http://remoteIp:";
  static const String remoteIp = "https://bloodcheck.ahmeteminsaglik.com";
  // static const String _host ="$remoteIp:$_port";
  static const String _host ="$remoteIp";
  // static const String _host =_localhost;
  // static const String _apiVersion = "/api/1.0";
  static const String _apiVersion = "";
  static const String _baseUrl = _host + _apiVersion;

  static String get baseUrl => _baseUrl;
  static String get apiVersion => _apiVersion;
}

