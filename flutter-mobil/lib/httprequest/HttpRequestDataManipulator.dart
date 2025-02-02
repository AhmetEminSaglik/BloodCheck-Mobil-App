import 'dart:convert';
import 'package:bloodcheck/httprequest/BaseHttpRequest.dart';
import 'package:bloodcheck/httprequest/ResponseEntity.dart';
import 'package:bloodcheck/util/HttpUtil.dart';
import 'package:bloodcheck/util/SharedPrefUtils.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HttpRequestDataManipulator {
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static Future<ResponseEntity> resetAllData() async {
    Uri url = Uri.parse("$_baseUrl/db");
    log.i("Url: $url ");
    var resp = await http.get(headers: HttpUtil.getHeaders(SharedPrefUtils.getToken()),url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    ResponseEntity respEntity = ResponseEntity.fromJson(jsonData);
    log.i("response: $respEntity");
    return respEntity;
  }
}