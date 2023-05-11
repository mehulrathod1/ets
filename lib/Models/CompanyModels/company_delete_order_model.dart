// To parse this JSON data, do
//
//     final companyDeleteOrderModel = companyDeleteOrderModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteOrderModel {
  String status;
  String message;
  String data;

  CompanyDeleteOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyDeleteOrderModel.fromRawJson(String str) =>
      CompanyDeleteOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteOrderModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteOrderModel(
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
