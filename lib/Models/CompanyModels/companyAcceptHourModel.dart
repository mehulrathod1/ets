// To parse this JSON data, do
//
//     final companyHourAcceptModel = companyHourAcceptModelFromJson(jsonString);

import 'dart:convert';

class CompanyHourAcceptModel {
  CompanyHourAcceptModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyHourAcceptModel.fromRawJson(String str) =>
      CompanyHourAcceptModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyHourAcceptModel.fromJson(Map<String, dynamic> json) =>
      CompanyHourAcceptModel(
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
