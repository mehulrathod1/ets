// To parse this JSON data, do
//
//     final companyDeleteEmployeeModel = companyDeleteEmployeeModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteEmployeeModel {
  CompanyDeleteEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyDeleteEmployeeModel.fromRawJson(String str) =>
      CompanyDeleteEmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteEmployeeModel(
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
