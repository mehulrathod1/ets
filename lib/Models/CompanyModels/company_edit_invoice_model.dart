// To parse this JSON data, do
//
//     final companyEditInvoiceModel = companyEditInvoiceModelFromJson(jsonString);

import 'dart:convert';

class CompanyEditInvoiceModel {
  String status;
  String message;
  String data;

  CompanyEditInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyEditInvoiceModel.fromRawJson(String str) =>
      CompanyEditInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyEditInvoiceModel.fromJson(Map<String, dynamic> json) =>
      CompanyEditInvoiceModel(
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
