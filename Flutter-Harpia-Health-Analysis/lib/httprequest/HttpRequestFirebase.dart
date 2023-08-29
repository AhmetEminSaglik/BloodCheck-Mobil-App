import 'dart:convert';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;
import '../model/firebase/FcmToken.dart';

class HttpRequestFirebase {
  static const String _classUrl = "/firebase/token";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  static void saveToken(FcmToken fcmToken) async {
    Uri url = Uri.parse(_baseUrl);
    print("URL : ${url}");
    print("REQUEST TOKEN :  : ${fcmToken.token}");

    Map<String, dynamic> requestData = {
      "patientId": fcmToken.patientId,
      "token": fcmToken.token,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    print(" RESP Result : ${resp.body}");
  }
}
