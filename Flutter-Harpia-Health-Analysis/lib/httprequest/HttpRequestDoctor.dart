import 'dart:convert';
import 'package:flutter_harpia_health_analysis/business/factory/UserFactory.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import 'package:flutter_harpia_health_analysis/model/user/Patient.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

import '../util/CustomLog.dart';

class HttpRequestDoctor {
  static const String _classUrl = "/doctors";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static CustomLog log = CustomLog(className: "HttpRequestDoctor");

  static Future<List<Patient>> getPatientListOfDoctorId(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id/patients");
    log.info("URL : $url");
    var resp = await http.get(url);

    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }

  static Future<List<Doctor>> getDoctorList() async {
    Uri url = Uri.parse(_baseUrl);
    log.info("URL : $url");
    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Doctor> doctorList = UserFactory.createDoctorList(respEntity.data);
    return doctorList;
  }

  Future<http.Response> signUp(Doctor user) async {
    Uri url = Uri.parse("$_baseUrl");
    log.info("URL : $url");
    Map<String, dynamic> requestData = user.toJson();
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }

  static Future<http.Response> savePatientTimer(
      PatientTimer patientTimer) async {
    Uri url = Uri.parse("${BaseHttpRequestConfig.baseUrl}/timers");
    log.info("URL : ${url}");
    Map<String, dynamic> requestData = {
      "hours": patientTimer.hours,
      "minutes": patientTimer.minutes,
      "patientId": patientTimer.patientId,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }

  static Future<Doctor> findById(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id");
    log.info("URL : $url");

    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    return UserFactory.createDoctor(respEntity.data);
  }

  Future<ResponseEntity> update(Doctor doctor) async {
    Uri url = Uri.parse("$_baseUrl");
    log.info("URL : $url");
    Map<String, dynamic> requestData = doctor.toJson();
    var resp = await http.put(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));

    Map<String, dynamic> jsonData = json.decode(resp.body);
    ResponseEntity respEntity = ResponseEntity.fromJson(jsonData);
    return respEntity;
  }
}
