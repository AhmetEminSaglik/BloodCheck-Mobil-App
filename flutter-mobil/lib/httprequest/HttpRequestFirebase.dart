import 'dart:convert';

import 'package:bloodcheck/httprequest/BaseHttpRequest.dart';
import 'package:bloodcheck/util/HttpUtil.dart';
import 'package:bloodcheck/util/SharedPrefUtils.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/firebase/FcmToken.dart';

class HttpRequestFirebase {
  static const String _classUrl = "/firebase/token";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static void saveFcmToken(FcmToken fcmToken) async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : ${url}");
    // log.i("REQUEST TOKEN :  : ${fcmToken.token}");

    Map<String, dynamic> requestData = {
      "userId": fcmToken.userId,
      "token": fcmToken.token,
    };
    var resp = await http.post(url,
        headers: HttpUtil.getHeaders(SharedPrefUtils.getToken()),
        body: jsonEncode(requestData));
    // log.i(" RESP Result : ${resp.body}");
  }

  static void deleteToken(FcmToken fcmToken) async {
    Uri url = Uri.parse(_baseUrl);
    log.i("URL : ${url}");
    // log.i("Delete REQUEST TOKEN :  : ${fcmToken.token}");

    Map<String, dynamic> requestData = {
      "userId": fcmToken.userId,
      "token": fcmToken.token,
    };

    // SharedPrefUtils.clearToken();

    var resp = await http.delete(url,
        headers: HttpUtil.getHeaders(SharedPrefUtils.getToken()),
        body: jsonEncode(requestData));
    // log.i(" RESP Result : ${resp.body}");
  }
}
