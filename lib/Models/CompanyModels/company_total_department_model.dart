// To parse this JSON data, do
//
//     final companyTotalDepartmentModel = companyTotalDepartmentModelFromJson(jsonString);

import 'dart:convert';

class CompanyTotalDepartmentModel {
  CompanyTotalDepartmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory CompanyTotalDepartmentModel.fromRawJson(String str) =>
      CompanyTotalDepartmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyTotalDepartmentModel.fromJson(Map<String, dynamic> json) =>
      CompanyTotalDepartmentModel(
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
