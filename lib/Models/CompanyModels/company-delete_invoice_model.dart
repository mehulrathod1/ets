// To parse this JSON data, do
//
//     final companyDeleteInvoiceModel = companyDeleteInvoiceModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteInvoiceModel {
  String status;
  String message;
  String data;

  CompanyDeleteInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyDeleteInvoiceModel.fromRawJson(String str) =>
      CompanyDeleteInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteInvoiceModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteInvoiceModel(
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
