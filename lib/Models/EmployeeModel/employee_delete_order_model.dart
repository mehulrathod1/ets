// To parse this JSON data, do
//
//     final employeeDeleteOrderModel = employeeDeleteOrderModelFromJson(jsonString);

import 'dart:convert';

class EmployeeDeleteOrderModel {
  EmployeeDeleteOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory EmployeeDeleteOrderModel.fromRawJson(String str) =>
      EmployeeDeleteOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeDeleteOrderModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDeleteOrderModel(
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
