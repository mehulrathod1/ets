// To parse this JSON data, do
//
//     final companyDeleteEstimateModel = companyDeleteEstimateModelFromJson(jsonString);

import 'dart:convert';

class CompanyDeleteEstimateModel {
  String status;
  String message;
  String data;

  CompanyDeleteEstimateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyDeleteEstimateModel.fromRawJson(String str) =>
      CompanyDeleteEstimateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyDeleteEstimateModel.fromJson(Map<String, dynamic> json) =>
      CompanyDeleteEstimateModel(
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
