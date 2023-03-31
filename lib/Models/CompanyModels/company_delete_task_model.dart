// To parse this JSON data, do
//
//     final companyDeleteTaskModel = companyDeleteTaskModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteTaskModel {
  CompanyDeleteTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyDeleteTaskModel.fromRawJson(String str) =>
      CompanyDeleteTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteTaskModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteTaskModel(
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
