// To parse this JSON data, do
//
//     final companyDeleteContactModel = companyDeleteContactModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteContactModel {
  CompanyDeleteContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyDeleteContactModel.fromRawJson(String str) =>
      CompanyDeleteContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteContactModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteContactModel(
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
