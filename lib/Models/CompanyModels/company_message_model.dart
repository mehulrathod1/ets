// To parse this JSON data, do
//
//     final companyMessageModel = companyMessageModelFromJson(jsonString);

import 'dart:convert';

class CompanyMessageModel {
  String status;
  String message;
  List<Datum> data;

  CompanyMessageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyMessageModel.fromRawJson(String str) =>
      CompanyMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyMessageModel.fromJson(Map<String, dynamic> json) =>
      CompanyMessageModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String employeeId;
  String companyId;
  String message;
  String companyMsg;
  String employeeMsg;
  DateTime timestamp;
  String employeeProfile;
  String companyProfile;

  Datum({
    required this.id,
    required this.employeeId,
    required this.companyId,
    required this.message,
    required this.companyMsg,
    required this.employeeMsg,
    required this.timestamp,
    required this.employeeProfile,
    required this.companyProfile,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeId: json["employee_id"],
        companyId: json["company_id"],
        message: json["message"],
        companyMsg: json["company_msg"],
        employeeMsg: json["employee_msg"],
        timestamp: DateTime.parse(json["timestamp"]),
        employeeProfile: json["employee_profile"],
        companyProfile: json["company_profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_id": employeeId,
        "company_id": companyId,
        "message": message,
        "company_msg": companyMsg,
        "employee_msg": employeeMsg,
        "timestamp": timestamp.toIso8601String(),
        "employee_profile": employeeProfile,
        "company_profile": companyProfile,
      };
}
