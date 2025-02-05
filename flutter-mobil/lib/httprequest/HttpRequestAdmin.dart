import 'dart:convert';

import 'package:bloodcheck/business/factory/UserFactory.dart';
import 'package:bloodcheck/model/user/Admin.dart';
import 'package:bloodcheck/util/HttpUtil.dart';
import 'package:bloodcheck/util/SharedPrefUtils.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'BaseHttpRequest.dart';
import 'ResponseEntity.dart';

class HttpRequestAdmin {
  static const String _classUrl = "/admins";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  static Future<Admin> findById(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id");
    // // log.i("URL : $url");

    var resp = await http.get(headers: HttpUtil.getHeaders(SharedPrefUtils.getToken()),url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    return UserFactory.createAdmin(respEntity.data);
  }

  static Future<ResponseEntity> update(Admin admin) async {
    Uri url = Uri.parse(_baseUrl);
    // log.i("URL : $url");
    Map<String, dynamic> requestData = admin.toJson();
    var resp = await http.put(url,
        headers: HttpUtil.getHeaders(SharedPrefUtils.getToken()), body: jsonEncode(requestData));

    Map<String, dynamic> jsonData = json.decode(resp.body);
    ResponseEntity respEntity = ResponseEntity.fromJson(jsonData);
    return respEntity;
  }

}
