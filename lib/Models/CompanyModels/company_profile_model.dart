// To parse this JSON data, do
//
//     final companyProfileModel = companyProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompanyProfileModel companyProfileModelFromJson(String str) =>
    CompanyProfileModel.fromJson(json.decode(str));

String companyProfileModelToJson(CompanyProfileModel data) =>
    json.encode(data.toJson());

class CompanyProfileModel {
  CompanyProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) =>
      CompanyProfileModel(
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
    required this.companyName,
    required this.contactPerson,
    required this.email,
    required this.username,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.companyLogo,
    required this.creditcardNo,
    required this.creditcardName,
    required this.creditcardExpDate,
    required this.securityCode,
  });

  String companyName;
  String contactPerson;
  String email;
  String username;
  String phone;
  String address;
  String city;
  String state;
  String zip;
  String companyLogo;
  String creditcardNo;
  String creditcardName;
  String creditcardExpDate;
  String securityCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        companyName: json["company_name"],
        contactPerson: json["contact_person"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        companyLogo: json["company_logo"],
        creditcardNo: json["creditcard_no"],
        creditcardName: json["creditcard_name"],
        creditcardExpDate: json["creditcard_exp_date"],
        securityCode: json["security_code"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "contact_person": contactPerson,
        "email": email,
        "username": username,
        "phone": phone,
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "company_logo": companyLogo,
        "creditcard_no": creditcardNo,
        "creditcard_name": creditcardName,
        "creditcard_exp_date": creditcardExpDate,
        "security_code": securityCode,
      };
}
