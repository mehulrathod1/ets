// To parse this JSON data, do
//
//     final companyAddInvoiceModel = companyAddInvoiceModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddInvoiceModel {
  String status;
  String message;
  dynamic data;

  CompanyAddInvoiceModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddInvoiceModel.fromRawJson(String str) =>
      CompanyAddInvoiceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddInvoiceModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddInvoiceModel(
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
