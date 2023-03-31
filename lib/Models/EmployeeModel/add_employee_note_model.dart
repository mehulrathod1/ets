// To parse this JSON data, do
//
//     final employeeAddNoteModel = employeeAddNoteModelFromJson(jsonString);

import 'dart:convert';

class EmployeeAddNoteModel {
  EmployeeAddNoteModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  int data;

  factory EmployeeAddNoteModel.fromRawJson(String str) =>
      EmployeeAddNoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeAddNoteModel.fromJson(Map<String, dynamic> json) =>
      EmployeeAddNoteModel(
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
