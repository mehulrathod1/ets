// To parse this JSON data, do
//
//     final companyRegistrationModel = companyRegistrationModelFromJson(jsonString);

import 'dart:convert';

class CompanyRegistrationModel {
  String status;
  String message;
  int data;

  CompanyRegistrationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyRegistrationModel.fromRawJson(String str) =>
      CompanyRegistrationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyRegistrationModel.fromJson(Map<String, dynamic> json) =>
      CompanyRegistrationModel(
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
