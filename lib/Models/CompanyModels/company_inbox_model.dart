// To parse this JSON data, do
//
//     final companyInboxModel = companyInboxModelFromJson(jsonString);

import 'dart:convert';

class CompanyInboxModel {
  String status;
  String message;
  List<Datum> data;

  CompanyInboxModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CompanyInboxModel.fromRawJson(String str) =>
      CompanyInboxModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompanyInboxModel.fromJson(Map<String, dynamic> json) =>
      CompanyInboxModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String employeeName;
  String email;

  Datum({
    required this.id,
    required this.employeeName,
    required this.email,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeName: json["employee_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "email": email,
      };
}


class Employee {
  final String id;
  final String employeeName;
  final String email;

  Employee({required this.id, required this.employeeName, required this.email});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employeeName: json['employee_name'],
      email: json['email'],
    );
  }
}