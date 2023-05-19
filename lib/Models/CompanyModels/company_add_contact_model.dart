// To parse this JSON data, do
//
//     final companyAddContactModel = companyAddContactModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddContactModel {
  String status;
  String message;
  bool data;

  CompanyAddContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddContactModel.fromRawJson(String str) =>
      CompanyAddContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddContactModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddContactModel(
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
