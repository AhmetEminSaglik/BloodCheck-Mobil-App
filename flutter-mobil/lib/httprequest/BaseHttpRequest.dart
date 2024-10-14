class BaseHttpRequestConfig {
  // static const String _localhost = "http://10.0.2.2:";
  static const String _port = "8080";
  // static const String _localhost = "http://192.168.1.56:$_port";
  // static const String _remotehost = "https://ws-bloodcheck.onrender.com";
  static const String remoteIp = "http://remote-ip:";
  static const String _host ="$remoteIp$_port";
  // static const String _host =_localhost;
  static const String _apiVersion = "/api/1.0";
  static const String _baseUrl = _host + _apiVersion;

  static String get baseUrl => _baseUrl;
  static String get apiVersion => _apiVersion;
}

