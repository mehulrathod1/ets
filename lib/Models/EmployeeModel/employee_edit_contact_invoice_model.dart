// To parse this JSON data, do
//
//     final employeeEditContactInvoiceModel = employeeEditContactInvoiceModelFromJson(jsonString);

import 'dart:convert';

class EmployeeEditContactInvoiceModel {
  String status;
  String message;
  dynamic data;

  EmployeeEditContactInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeEditContactInvoiceModel.fromRawJson(String str) =>
      EmployeeEditContactInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeEditContactInvoiceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeEditContactInvoiceModel(
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
