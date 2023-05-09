// To parse this JSON data, do
//
//     final agencyRegisterModel = agencyRegisterModelFromJson(jsonString);

import 'dart:convert';

class AgencyRegisterModel {
  String status;
  String message;
  int data;

  AgencyRegisterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AgencyRegisterModel.fromRawJson(String str) =>
      AgencyRegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AgencyRegisterModel.fromJson(Map<String, dynamic> json) =>
      AgencyRegisterModel(
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
