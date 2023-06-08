// To parse this JSON data, do
//
//     final employeeSendMessageModel = employeeSendMessageModelFromJson(jsonString);

import 'dart:convert';

class EmployeeSendMessageModel {
  String status;
  String message;
  int data;

  EmployeeSendMessageModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeSendMessageModel.fromRawJson(String str) =>
      EmployeeSendMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeSendMessageModel.fromJson(Map<String, dynamic> json) =>
      EmployeeSendMessageModel(
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
