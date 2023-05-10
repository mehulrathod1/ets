// To parse this JSON data, do
//
//     final companyEditEmployeeModel = companyEditEmployeeModelFromJson(jsonString);

import 'dart:convert';

CompanyEditEmployeeModel companyEditEmployeeModelFromJson(String str) =>
    CompanyEditEmployeeModel.fromJson(json.decode(str));

String companyEditEmployeeModelToJson(CompanyEditEmployeeModel data) =>
    json.encode(data.toJson());

class CompanyEditEmployeeModel {
  String status;
  String message;
  String data;

  CompanyEditEmployeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyEditEmployeeModel.fromJson(Map<String, dynamic> json) =>
      CompanyEditEmployeeModel(
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
