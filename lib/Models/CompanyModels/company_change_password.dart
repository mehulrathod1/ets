// To parse this JSON data, do
//
//     final companyChangePasswordModel = companyChangePasswordModelFromJson(jsonString);

import 'dart:convert';

class CompanyChangePasswordModel {
  String status;
  String message;
  String data;

  CompanyChangePasswordModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyChangePasswordModel.fromRawJson(String str) =>
      CompanyChangePasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      CompanyChangePasswordModel(
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
