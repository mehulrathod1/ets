// To parse this JSON data, do
//
//     final companyAddEventModel = companyAddEventModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddEventModel {
  String status;
  String message;
  int data;

  CompanyAddEventModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddEventModel.fromRawJson(String str) =>
      CompanyAddEventModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddEventModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddEventModel(
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
