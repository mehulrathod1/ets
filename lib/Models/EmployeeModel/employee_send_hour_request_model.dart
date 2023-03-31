// To parse this JSON data, do
//
//     final employeeSendHourRequestModel = employeeSendHourRequestModelFromJson(jsonString);

import 'dart:convert';

EmployeeSendHourRequestModel employeeSendHourRequestModelFromJson(String str) =>
    EmployeeSendHourRequestModel.fromJson(json.decode(str));

String employeeSendHourRequestModelToJson(EmployeeSendHourRequestModel data) =>
    json.encode(data.toJson());

class EmployeeSendHourRequestModel {
  EmployeeSendHourRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory EmployeeSendHourRequestModel.fromJson(Map<String, dynamic> json) =>
      EmployeeSendHourRequestModel(
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
