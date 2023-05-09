// To parse this JSON data, do
//
//     final companyUpdateProfileModel = companyUpdateProfileModelFromJson(jsonString);

import 'dart:convert';

class CompanyUpdateProfileModel {
  String status;
  String message;
  bool data;

  CompanyUpdateProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyUpdateProfileModel.fromRawJson(String str) =>
      CompanyUpdateProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyUpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      CompanyUpdateProfileModel(
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
