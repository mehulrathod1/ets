// To parse this JSON data, do
//
//     final companyAddTaskModel = companyAddTaskModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddTaskModel {
  String status;
  String message;
  int data;

  CompanyAddTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddTaskModel.fromRawJson(String str) =>
      CompanyAddTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddTaskModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddTaskModel(
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
