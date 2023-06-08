// To parse this JSON data, do
//
//     final employeeAddEstimateModel = employeeAddEstimateModelFromJson(jsonString);

import 'dart:convert';

class EmployeeAddEstimateModel {
  String status;
  String message;
  int data;

  EmployeeAddEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeAddEstimateModel.fromRawJson(String str) =>
      EmployeeAddEstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddEstimateModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAddEstimateModel(
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
