// To parse this JSON data, do
//
//     final companyAddDepartmentModel = companyAddDepartmentModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddDepartmentModel {
  CompanyAddDepartmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory CompanyAddDepartmentModel.fromRawJson(String str) =>
      CompanyAddDepartmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddDepartmentModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddDepartmentModel(
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
