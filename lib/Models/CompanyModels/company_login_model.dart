// To parse this JSON data, do
//
//     final companyLoginModel = companyLoginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompanyLoginModel companyLoginModelFromJson(String str) =>
    CompanyLoginModel.fromJson(json.decode(str));

String companyLoginModelToJson(CompanyLoginModel data) =>
    json.encode(data.toJson());

class CompanyLoginModel {
  CompanyLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyLoginModel.fromJson(Map<String, dynamic> json) =>
      CompanyLoginModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.message,
    required this.token,
    required this.email,
    required this.id,
    required this.companyName,
    required this.contactPerson,
  });

  String message;
  String token;
  String email;
  String id;
  String companyName;
  String contactPerson;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        token: json["token"],
        email: json["email"],
        id: json["id"],
        companyName: json["Company Name"],
        contactPerson: json["Contact Person"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "email": email,
        "id": id,
        "Company Name": companyName,
        "Contact Person": contactPerson,
      };
}
