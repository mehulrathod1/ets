// To parse this JSON data, do
//
//     final companyAddEstimateModel = companyAddEstimateModelFromJson(jsonString);

import 'dart:convert';

class CompanyAddEstimateModel {
  String status;
  String message;
  int data;

  CompanyAddEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyAddEstimateModel.fromRawJson(String str) =>
      CompanyAddEstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyAddEstimateModel.fromJson(Map<String, dynamic> json) =>
      CompanyAddEstimateModel(
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
