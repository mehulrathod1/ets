// To parse this JSON data, do
//
//     final employeeAddInvoiceModel = employeeAddInvoiceModelFromJson(jsonString);

import 'dart:convert';

class EmployeeAddInvoiceModel {
  String status;
  String message;
  dynamic data;

  EmployeeAddInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeAddInvoiceModel.fromRawJson(String str) =>
      EmployeeAddInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddInvoiceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAddInvoiceModel(
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
