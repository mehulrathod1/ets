// To parse this JSON data, do
//
//     final employeeLoginModel = employeeLoginModelFromJson(jsonString);

import 'dart:convert';

EmployeeLoginModel employeeLoginModelFromJson(String str) =>
    EmployeeLoginModel.fromJson(json.decode(str));

String employeeLoginModelToJson(EmployeeLoginModel data) =>
    json.encode(data.toJson());

class EmployeeLoginModel {
  EmployeeLoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory EmployeeLoginModel.fromJson(Map<String, dynamic> json) =>
      EmployeeLoginModel(
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
    required this.employeeName,
  });

  String message;
  String token;
  String email;
  String id;
  String employeeName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        token: json["token"],
        email: json["email"],
        id: json["id"],
        employeeName: json["Employee Name"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "email": email,
        "id": id,
        "Employee Name": employeeName,
      };
}
