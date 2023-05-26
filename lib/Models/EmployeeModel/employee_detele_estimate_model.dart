// To parse this JSON data, do
//
//     final employeeDeleteEstimate = employeeDeleteEstimateFromJson(jsonString);

import 'dart:convert';

class EmployeeDeleteEstimate {
  String status;
  String message;
  String data;

  EmployeeDeleteEstimate({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeDeleteEstimate.fromRawJson(String str) =>
      EmployeeDeleteEstimate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  factory EmployeeDeleteEstimate.fromJson(Map<String, dynamic> json) =>
      EmployeeDeleteEstimate(
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
