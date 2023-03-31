// To parse this JSON data, do
//
//     final employeeDeleteTaskModel = employeeDeleteTaskModelFromJson(jsonString);

import 'dart:convert';

class EmployeeDeleteTaskModel {
  EmployeeDeleteTaskModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory EmployeeDeleteTaskModel.fromRawJson(String str) =>
      EmployeeDeleteTaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeDeleteTaskModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDeleteTaskModel(
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
