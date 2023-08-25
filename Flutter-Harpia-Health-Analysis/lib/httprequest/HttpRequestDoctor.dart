import 'dart:convert';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/business/factory/UserFactory.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import 'package:flutter_harpia_health_analysis/model/user/Patient.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

class HttpRequestDoctor {
  static const String _classUrl = "/doctors";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  static Future<List<Patient>> getPatientListOfDoctorId(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id/patients");
    print("URL : $url");
    var resp = await http.get(url);

    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }

  static Future<List<Doctor>> getDoctorList() async {
    Uri url = Uri.parse(_baseUrl);
    print("URL : $url");
    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Doctor> doctorList = UserFactory.createDoctorList(respEntity.data);
    return doctorList;
  }

  Future<http.Response> signUp(Doctor user) async {
    Uri url = Uri.parse("$_baseUrl");
    print("URL : $url");
    Map<String, dynamic> requestData = user.toJson();
    print("to json  $requestData");
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    print('requestData : $requestData');
    print('resp : $resp');
    print('resp.body : ${resp.body}');
    return resp;
  }

  static Future<http.Response> savePatientTimer(
      PatientTimer patientTimer) async {
    Uri url =
        Uri.parse("${BaseHttpRequestConfig.baseUrl}/timers");
    print("URL : ${url}");
    Map<String, dynamic> requestData = {
      "hours": patientTimer.hours,
      "minutes": patientTimer.minutes,
      "patientId": patientTimer.patientId,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }
}
