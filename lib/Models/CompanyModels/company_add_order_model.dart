// To parse this JSON data, do
//
//     final companyAddOrderModel = companyAddOrderModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddOrderModel {
  String status;
  String message;
  int data;

  CompanyAddOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddOrderModel.fromRawJson(String str) =>
      CompanyAddOrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddOrderModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddOrderModel(
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
