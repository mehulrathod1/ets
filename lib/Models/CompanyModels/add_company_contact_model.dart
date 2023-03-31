// To parse this JSON data, do
//
//     final addCompanyContactModel = addCompanyContactModelFromJson(jsonString);

import 'dart:convert';

AddCompanyContactModel addCompanyContactModelFromJson(String str) =>
    AddCompanyContactModel.fromJson(json.decode(str));

String addCompanyContactModelToJson(AddCompanyContactModel data) =>
    json.encode(data.toJson());

class AddCompanyContactModel {
  AddCompanyContactModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<dynamic> data;

  factory AddCompanyContactModel.fromJson(Map<String, dynamic> json) =>
      AddCompanyContactModel(
        status: json["status"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
