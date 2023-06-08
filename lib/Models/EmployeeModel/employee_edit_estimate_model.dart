// To parse this JSON data, do
//
//     final employeeEditEstimate = employeeEditEstimateFromJson(jsonString);

import 'dart:convert';

class EmployeeEditEstimateModel {
  String status;
  String message;
  String data;

  EmployeeEditEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeEditEstimateModel.fromRawJson(String str) =>
      EmployeeEditEstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeEditEstimateModel.fromJson(Map<String, dynamic> json) =>
      EmployeeEditEstimateModel(
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
