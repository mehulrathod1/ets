// To parse this JSON data, do
//
//     final addCompanyContactModel = addCompanyContactModelFromJson(jsonString);

import 'dart:convert';

class AddCompanyContactModel {
  AddCompanyContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory AddCompanyContactModel.fromRawJson(String str) =>
      AddCompanyContactModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddCompanyContactModel.fromJson(Map<String, dynamic> json) =>
      AddCompanyContactModel(
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
