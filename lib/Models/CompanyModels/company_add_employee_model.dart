// To parse this JSON data, do
//
//     final companyAddEmployeeModel = companyAddEmployeeModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddEmployeeModel {
  CompanyAddEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyAddEmployeeModel.fromRawJson(String str) =>
      CompanyAddEmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddEmployeeModel(
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
