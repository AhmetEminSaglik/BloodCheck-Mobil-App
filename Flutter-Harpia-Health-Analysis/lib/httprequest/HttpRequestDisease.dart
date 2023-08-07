/*
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/old-Disease.dart';
import 'package:flutter_harpia_health_analysis/business/factory/DiseaseFactory.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

class HttpRequestDisease {
  static const String _classUrl = "/diseases";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  Future<List<Disease>> getDiseaseListOfPatientid(int id) async {
    Uri uri = Uri.parse("$_baseUrl/patient/id/$id");
    var resp = await http.get(uri);
    debugPrint(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    print("respEntity $respEntity");
    List<Disease> list = DiseaseFactory.createDiseaseList(respEntity.data);
    return list;

    // var respEntity = ResponseEntity.fromJson(jsonData);
    // return jsonData;

    */
/*List<Disease> diseaseList = (respEntity.data as List)
        .map((data) => Disease.fromJson(data))
        .toList();

    diseaseList.forEach((e) {
      print("e : $e");
    });*//*

  }

// Future<void> getAllUserData() async {
//   Uri url = Uri.parse(_baseUrl);
//   var resp = await http.get(url);
//   debugPrint(resp.body);
// }

// Future<http.Response> login(String username, String password) async {
//   Uri url = Uri.parse("$_baseUrl/user/login");
//   var requestData = {"username": username, "password": password};
// Map<String, dynamic> requestData = {
//   "username": username,
//   "password": password,
// };
// var resp = await http.post(url,
//     headers: HttpUtil.header, body: jsonEncode(requestData));
// return resp;
// }
}
*/
