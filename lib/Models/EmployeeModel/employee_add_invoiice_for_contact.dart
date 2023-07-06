// To parse this JSON data, do
//
//     final employeeAddInvoiceForContactModel = employeeAddInvoiceForContactModelFromJson(jsonString);

import 'dart:convert';

class EmployeeAddInvoiceForContactModel {
  String status;
  String message;
  dynamic data;

  EmployeeAddInvoiceForContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmployeeAddInvoiceForContactModel.fromRawJson(String str) =>
      EmployeeAddInvoiceForContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddInvoiceForContactModel.fromJson(
          Map<String, dynamic> json) =>
      EmployeeAddInvoiceForContactModel(
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
