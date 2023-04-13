// To parse this JSON data, do
//
//     final companyHourRejectModel = companyHourRejectModelFromJson(jsonString);

import 'dart:convert';

class CompanyHourRejectModel {
  CompanyHourRejectModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  String data;

  factory CompanyHourRejectModel.fromRawJson(String str) =>
      CompanyHourRejectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyHourRejectModel.fromJson(Map<String, dynamic> json) =>
      CompanyHourRejectModel(
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
