// To parse this JSON data, do
//
//     final companyDeleteDepartmentModel = companyDeleteDepartmentModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteDepartmentModel {
  CompanyDeleteDepartmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyDeleteDepartmentModel.fromRawJson(String str) =>
      CompanyDeleteDepartmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteDepartmentModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteDepartmentModel(
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
