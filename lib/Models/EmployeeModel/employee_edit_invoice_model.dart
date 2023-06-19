// To parse this JSON data, do
//
//     final employeeEditInvoiceModel = employeeEditInvoiceModelFromJson(jsonString);

import 'dart:convert';

class EmployeeEditInvoiceModel {
  String status;
  String message;
  dynamic data;

  EmployeeEditInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeEditInvoiceModel.fromRawJson(String str) =>
      EmployeeEditInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeEditInvoiceModel.fromJson(Map<String, dynamic> json) =>
      EmployeeEditInvoiceModel(
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
