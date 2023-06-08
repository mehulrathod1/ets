// To parse this JSON data, do
//
//     final companyDeleteAttendanceModel = companyDeleteAttendanceModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteAttendanceModel {
  String status;
  String message;
  String data;

  CompanyDeleteAttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyDeleteAttendanceModel.fromRawJson(String str) =>
      CompanyDeleteAttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteAttendanceModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteAttendanceModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
