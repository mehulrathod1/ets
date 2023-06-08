// To parse this JSON data, do
//
//     final companyDeleteViewAttendanceModel = companyDeleteViewAttendanceModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteViewAttendanceModel {
  String status;
  String message;
  String data;

  CompanyDeleteViewAttendanceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyDeleteViewAttendanceModel.fromRawJson(String str) =>
      CompanyDeleteViewAttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteViewAttendanceModel.fromJson(
          Map<String, dynamic> json) =>
      CompanyDeleteViewAttendanceModel(
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
