// To parse this JSON data, do
//
//     final companyEditDepartmentModel = companyEditDepartmentModelFromJson(jsonString);

import 'dart:convert';

class CompanyEditDepartmentModel {
  String status;
  String message;
  bool data;

  CompanyEditDepartmentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyEditDepartmentModel.fromRawJson(String str) =>
      CompanyEditDepartmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyEditDepartmentModel.fromJson(Map<String, dynamic> json) =>
      CompanyEditDepartmentModel(
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
