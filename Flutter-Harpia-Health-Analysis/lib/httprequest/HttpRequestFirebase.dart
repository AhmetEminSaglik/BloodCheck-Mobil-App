import 'dart:convert';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;
import '../model/firebase/FcmToken.dart';
import '../util/CustomLog.dart';

class HttpRequestFirebase {
  static const String _classUrl = "/firebase/token";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static CustomLog log = CustomLog(className: "HttpRequestFirebase");

  static void saveToken(FcmToken fcmToken) async {
    Uri url = Uri.parse(_baseUrl);
    log.info("URL : ${url}");
    log.info("REQUEST TOKEN :  : ${fcmToken.token}");

    Map<String, dynamic> requestData = {
      "userId": fcmToken.userId,
      "token": fcmToken.token,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    log.info(" RESP Result : ${resp.body}");
  }
}
