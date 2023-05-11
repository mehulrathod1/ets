// To parse this JSON data, do
//
//     final companySubscription = companySubscriptionFromJson(jsonString);

import 'dart:convert';

class CompanySubscriptionModel {
  String status;
  String message;
  bool data;

  CompanySubscriptionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanySubscriptionModel.fromRawJson(String str) =>
      CompanySubscriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanySubscriptionModel.fromJson(Map<String, dynamic> json) =>
      CompanySubscriptionModel(
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
