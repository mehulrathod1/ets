// To parse this JSON data, do
//
//     final companyLocationRequestModel = companyLocationRequestModelFromJson(jsonString);

import 'dart:convert';

class CompanyLocationRequestModel {
  CompanyLocationRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory CompanyLocationRequestModel.fromRawJson(String str) =>
      CompanyLocationRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyLocationRequestModel.fromJson(Map<String, dynamic> json) =>
      CompanyLocationRequestModel(
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
